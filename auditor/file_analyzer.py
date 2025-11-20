from PIL import Image
from PIL.ExifTags import TAGS
import imagehash
from pypdf import PdfReader
from datetime import datetime
import io
import json


class FileAnalyzer:
    """Analyzes files for signs of editing and manipulation"""
    
    SUSPICIOUS_SOFTWARE = [
        'photoshop', 'gimp', 'paint.net', 'pixlr', 'photoscape',
        'adobe acrobat', 'foxit', 'pdf editor', 'nitro', 'pdfelement'
    ]
    
    @staticmethod
    def analyze_image(file_path):
        """Analyze image file for editing indicators"""
        results = {
            'has_exif': False,
            'exif_software': '',
            'exif_datetime_original': '',
            'exif_datetime_modified': '',
            'exif_anomalies': '',
            'perceptual_hash': '',
            'metadata_mismatch': False,
            'suspicious_software': False,
            'detection_summary': '',
            'confidence_score': 100.0
        }
        
        try:
            with Image.open(file_path) as img:
                # Calculate perceptual hash
                results['perceptual_hash'] = str(imagehash.average_hash(img))
                
                # Extract EXIF data
                exif_data = img._getexif()
                
                if exif_data:
                    results['has_exif'] = True
                    exif_dict = {}
                    
                    for tag_id, value in exif_data.items():
                        tag = TAGS.get(tag_id, tag_id)
                        exif_dict[tag] = value
                    
                    # Check for editing software
                    software = exif_dict.get('Software', '')
                    if software:
                        results['exif_software'] = str(software)
                        if any(sus in software.lower() for sus in FileAnalyzer.SUSPICIOUS_SOFTWARE):
                            results['suspicious_software'] = True
                            results['confidence_score'] -= 40
                    
                    # Check datetime fields
                    dt_original = exif_dict.get('DateTimeOriginal', '')
                    dt_modified = exif_dict.get('DateTime', '')
                    
                    if dt_original:
                        results['exif_datetime_original'] = str(dt_original)
                    if dt_modified:
                        results['exif_datetime_modified'] = str(dt_modified)
                    
                    # Check for datetime mismatch
                    if dt_original and dt_modified and dt_original != dt_modified:
                        results['metadata_mismatch'] = True
                        results['confidence_score'] -= 30
                    
                    # Store anomalies
                    anomalies = []
                    if results['suspicious_software']:
                        anomalies.append(f"Editing software detected: {software}")
                    if results['metadata_mismatch']:
                        anomalies.append("DateTime mismatch between original and modified")
                    
                    results['exif_anomalies'] = json.dumps(anomalies)
                    
                else:
                    # No EXIF could mean stripped metadata (suspicious)
                    results['confidence_score'] -= 20
                    results['exif_anomalies'] = json.dumps(['No EXIF data found - metadata may have been stripped'])
                
        except Exception as e:
            results['detection_summary'] = f"Error analyzing image: {str(e)}"
            results['confidence_score'] = 0
        
        # Generate summary
        if results['confidence_score'] >= 80:
            results['detection_summary'] = "File appears unmodified"
        elif results['confidence_score'] >= 50:
            results['detection_summary'] = "File shows signs of possible editing"
        else:
            results['detection_summary'] = "File likely edited or manipulated"
        
        return results
    
    @staticmethod
    def analyze_pdf(file_path):
        """Analyze PDF file for editing indicators"""
        results = {
            'pdf_creator': '',
            'pdf_producer': '',
            'pdf_creation_date': '',
            'pdf_modification_date': '',
            'pdf_page_count': 0,
            'pdf_anomalies': '',
            'metadata_mismatch': False,
            'suspicious_software': False,
            'detection_summary': '',
            'confidence_score': 100.0
        }
        
        try:
            with open(file_path, 'rb') as f:
                pdf = PdfReader(f)
                
                # Get page count
                results['pdf_page_count'] = len(pdf.pages)
                
                # Get metadata
                metadata = pdf.metadata
                
                if metadata:
                    creator = metadata.get('/Creator', '')
                    producer = metadata.get('/Producer', '')
                    creation_date = metadata.get('/CreationDate', '')
                    mod_date = metadata.get('/ModDate', '')
                    
                    results['pdf_creator'] = str(creator) if creator else ''
                    results['pdf_producer'] = str(producer) if producer else ''
                    results['pdf_creation_date'] = str(creation_date) if creation_date else ''
                    results['pdf_modification_date'] = str(mod_date) if mod_date else ''
                    
                    # Check for editing software
                    software_check = f"{creator} {producer}".lower()
                    if any(sus in software_check for sus in FileAnalyzer.SUSPICIOUS_SOFTWARE):
                        results['suspicious_software'] = True
                        results['confidence_score'] -= 40
                    
                    # Check for date mismatch
                    if creation_date and mod_date and creation_date != mod_date:
                        results['metadata_mismatch'] = True
                        results['confidence_score'] -= 30
                    
                    # Store anomalies
                    anomalies = []
                    if results['suspicious_software']:
                        anomalies.append(f"PDF editing software detected: {creator} / {producer}")
                    if results['metadata_mismatch']:
                        anomalies.append("Creation and modification dates differ")
                    
                    results['pdf_anomalies'] = json.dumps(anomalies)
                else:
                    # No metadata is suspicious
                    results['confidence_score'] -= 30
                    results['pdf_anomalies'] = json.dumps(['No PDF metadata found'])
                    
        except Exception as e:
            results['detection_summary'] = f"Error analyzing PDF: {str(e)}"
            results['confidence_score'] = 0
        
        # Generate summary
        if results['confidence_score'] >= 80:
            results['detection_summary'] = "PDF appears unmodified"
        elif results['confidence_score'] >= 50:
            results['detection_summary'] = "PDF shows signs of possible editing"
        else:
            results['detection_summary'] = "PDF likely edited or manipulated"
        
        return results
    
    @staticmethod
    def determine_integrity_status(confidence_score):
        """Determine integrity status based on confidence score"""
        if confidence_score >= 80:
            return 'clean'
        elif confidence_score >= 50:
            return 'suspicious'
        else:
            return 'modified'