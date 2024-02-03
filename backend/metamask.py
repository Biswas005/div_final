from web3 import Web3
from flask import jsonify

def handle_metamask_login(content):
    signature = content['signature']
    public_address = content['public_address']
    original_message = content['original_message']

    w3 = Web3(Web3.HTTPProvider('YOUR_INFURA_ENDPOINT'))
    recovered_address = w3.eth.account.recover_message(text=original_message, signature=signature)

    if recovered_address.lower() == public_address.lower():
        # The signature is valid, handle the login logic (create session, etc.)
        return jsonify({'status': 'success', 'message': 'Logged in successfully'})
    else:
        return jsonify({'status': 'error', 'message': 'Invalid signature'}), 401
