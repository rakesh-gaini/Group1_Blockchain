import hashlib
import time
import secrets
import string
import sys

max_nonce = 2 ** 32  # 4 billion


def proof_of_work(header, target):

    #raise NotImplementedError #TODO: remove this line before you start

    # Find and return a valid nonce

    return None


if __name__ == '__main__':

    difficulty = int(sys.argv[1]) # num of bits
    target = 2 ** (256 - difficulty)

    print(f'Difficulty target: {target}')

    # Generate a fake block header
    block_header = ''.join(secrets.choice(string.ascii_letters) for i in range(50))
    print(f'Header: {block_header}')

    # Find nonce
    nonce = proof_of_work(block_header, target)
    if nonce != None:
        print(f'Nonce: {nonce}')
    else:
        print('Failed')
