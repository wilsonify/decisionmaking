import os

import requests
import subprocess

repo_owner = "wilsonify"
repo_name = "decisionmaking"
github_token = os.getenv('GITHUB_TOKEN')


def get_open_pull_requests():
    print(" Fetch the list of open pull requests")
    pull_requests_url = f'https://api.github.com/repos/{repo_owner}/{repo_name}/pulls'
    headers = {'Authorization': f'token {github_token}'}
    response = requests.get(pull_requests_url, headers=headers)
    pull_requests_data = response.json()
    open_pull_request_numbers = [pr['number'] for pr in pull_requests_data]
    return open_pull_request_numbers


def squash_merge_pull_request(pull_request_number):
    print(" Get the pull request details")
    pull_request_url = f'https://api.github.com/repos/{repo_owner}/{repo_name}/pulls/{pull_request_number}'
    headers = {'Authorization': f'token {github_token}'}
    response = requests.get(pull_request_url, headers=headers)
    pull_request_data = response.json()
    print(" Squash and merge the pull request")
    merge_url = pull_request_data['url'] + '/merge'
    merge_data = {'commit_title': 'Squash and Merge'}
    response = requests.put(merge_url, json=merge_data, headers=headers)
    print(f'Pull request {pull_request_number} response = {response.json()}')


if __name__ == "__main__":
    pull_requests = get_open_pull_requests()
    for pull_request_number in pull_requests[:2]:
        print(f"pull_request_number = {pull_request_number}")
        squash_merge_pull_request(pull_request_number)
