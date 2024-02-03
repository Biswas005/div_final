import os
import requests
from web3 import Web3

# Initialize web3.py with the Polygon RPC endpoint
polygon_rpc_endpoint = "https://rpc-mainnet.matic.network"  # Use the appropriate endpoint
web3 = Web3(Web3.HTTPProvider(polygon_rpc_endpoint))

# Load your Ethereum private key (replace with your own private key)
private_key = os.getenv('YOUR_PRIVATE_KEY')

# Define the Polygon contract address where you want to store the IPFS hashes
contract_address = "0xYourContractAddress"  # Replace with your contract address
abi = [...]  # Replace with the ABI of your contract

# Initialize the contract instance
contract = web3.eth.contract(address=contract_address, abi=abi)

def upload_file_to_pinata(file_path, pinata_api_key, pinata_secret_api_key):
    # Define Pinata API endpoint and headers
    pinata_url = "https://api.pinata.cloud/pinning/pinFileToIPFS"
    headers = {
        "pinata_api_key": pinata_api_key,
        "pinata_secret_api_key": pinata_secret_api_key,
    }

    # Create a FormData object with the file
    files = {
        "file": (os.path.basename(file_path), open(file_path, "rb")),
    }

    # Make the request to Pinata
    response = requests.post(pinata_url, files=files, headers=headers)

    if response.status_code == 200:
        return response.json()  # Parse the JSON response from Pinata
    else:
        return None  # Handle the error or return an appropriate response

def store_ipfs_hash_on_polygon(ipfs_hash):
    # Ensure you have an Ethereum account with enough funds to execute transactions

    # Prepare the transaction
    nonce = web3.eth.getTransactionCount(web3.toChecksumAddress(YOUR_ETH_ADDRESS), "pending")
    gas_price = web3.toWei('10', 'gwei')  # Adjust gas price as needed
    gas_limit = 100000  # Adjust gas limit as needed

    transaction = contract.functions.storeIPFSHash(ipfs_hash).buildTransaction({
        'chainId': 137,  # Polygon Mainnet chain ID
        'gas': gas_limit,
        'gasPrice': gas_price,
        'nonce': nonce,
    })

    # Sign the transaction
    signed_transaction = web3.eth.account.signTransaction(transaction, private_key=private_key)

    # Send the transaction
    tx_hash = web3.eth.sendRawTransaction(signed_transaction.rawTransaction)

    return tx_hash.hex()

if __name__ == '__main__':
    # Example: Upload a file to Pinata and store the hash on Polygon
    pinata_api_key = "YourPinataAPIKey"
    pinata_secret_api_key = "YourPinataSecretAPIKey"
    file_path = "path/to/your/file.txt"  # Replace with the path to your file

    pinata_response = upload_file_to_pinata(file_path, pinata_api_key, pinata_secret_api_key)

    if pinata_response:
        ipfs_hash = pinata_response.get('IpfsHash')
        tx_hash = store_ipfs_hash_on_polygon(ipfs_hash)
        print(f'IPFS Hash: {ipfs_hash}')
        print(f'Transaction Hash: {tx_hash}')
    else:
        print('Failed to upload file to Pinata or retrieve IPFS hash.')
