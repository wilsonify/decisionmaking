import os

import requests

owner = "wilsonify"
repo = "decisionmaking"
github_token = os.getenv('GITHUB_TOKEN')


def get_merged_branches():
    url = f'https://api.github.com/repos/{owner}/{repo}/branches'
    headers = {'Authorization': f'token {github_token}'}
    response = requests.get(url, headers=headers)
    branches = response.json()
    unprotected_branches = [branch['name'] for branch in branches if
                            not branch['protected'] and branch['name'] != "master"]
    return unprotected_branches


def delete_branch(branch):
    print(f"branch = {branch}")
    url = f'https://api.github.com/repos/{owner}/{repo}/git/refs/heads/{branch}'
    headers = {'Authorization': f'token {github_token}'}
    response = requests.delete(url, headers=headers)
    print(f"response = {response}")


def main():
    branches = get_merged_branches()
    while branches:
        branches = get_merged_branches()
        for branch in branches:
            print(f"branch = {branch}")
            delete_branch(branch)


if __name__ == "__main__":
    main()
