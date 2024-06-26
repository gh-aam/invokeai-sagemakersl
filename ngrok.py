import argparse
import json
from pyngrok import ngrok, conf
import os
import signal
import sys
import subprocess

def get_saved_data():
    try:
        with open('data.json', 'r') as file:
            data = json.load(file)
        return data
    except (FileNotFoundError, json.JSONDecodeError):
        return None

def save_data(data):
    with open('data.json', 'w') as file:
        json.dump(data, file)

def signal_handler(sig, frame):
    print('\nCtrl+C was pressed!')
    sys.exit(0)

def main():
    parser = argparse.ArgumentParser(description='Console app with token and domain arguments')
    parser.add_argument('--token', help='Specify the token')
    parser.add_argument('--domain', help='Specify the domain')
    parser.add_argument('--reset', action='store_true', help='Reset saved data')

    args = parser.parse_args()

    saved_data = get_saved_data()

    if args.reset:
        if saved_data is not None:
            saved_data = {'token': '', 'domain': ''}
    else:
        if saved_data is not None:
            if args.token:
                saved_data['token'] = args.token
            if args.domain:
                saved_data['domain'] = args.domain
        else:
            saved_data = {'token': '', 'domain': ''}

    if args.token is None:
        if saved_data and saved_data['token']:
            args.token = saved_data['token']
        else:
            args.token = input('Enter Ngrok token: ')
            if args.token == '':
                args.token = input('Enter Ngrok token: ')
            saved_data['token'] = args.token

    if args.domain is None:
        args.domain = ''
        if saved_data and saved_data['domain']:
            args.domain = saved_data['domain']
        else:
            args.domain = input('Enter Ngrok domain: ')
            saved_data['domain'] = args.domain

    save_data(saved_data)

    print(f'Token: {args.token}')
    print(f'Domain: {args.domain}')

    if args.token != '':
        ngrok.kill()
        srv = ngrok.connect(9090, pyngrok_config=conf.PyngrokConfig(auth_token=args.token), bind_tls=True, domain=args.domain).public_url
        print(f'URL: {srv}')

        signal.signal(signal.SIGINT, signal_handler)
        print('Press Ctrl+C to exit!')
        cmd = 'invokeai-web'
        env = os.environ.copy()
        subprocess.run(cmd, shell=True, env=env)
        signal.pause()
    else:
        print('Ngrok token is required. Get one from https://ngrok.com.')

if __name__ == '__main__':
    main()
