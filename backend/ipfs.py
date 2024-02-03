import os
from flask import jsonify
from pinata import Pinata

# Load credentials from environment variables
api_key = os.getenv('PINATA_API_KEY')
secret_key = os.getenv('PINATA_SECRET_KEY')
access_token = os.getenv('PINATA_ACCESS_TOKEN')

pinata = Pinata(api_key, secret_key, access_token)

def upload_file_to_ipfs(request):
    if 'file' not in request.files:
        return 'No file part'
    
    file = request.files['file']
    if file.filename == '':
        return 'No selected file'

    if file:
        response = pinata.pin_file_to_ipfs(file)
        if response['IpfsHash']:
            # Store the hash in the blockchain or your database
            return jsonify({'status': 'success', 'ipfs_hash': response['IpfsHash']})
        else:
            return jsonify({'status': 'error', 'message': 'Failed to upload to IPFS'}), 500
