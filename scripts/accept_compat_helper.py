import subprocess


def get_remote_branches():
    print(" Fetch the list of remote branches")
    result = subprocess.run(['git', 'branch', '-r'], stdout=subprocess.PIPE, text=True)
    remote_branches = result.stdout.splitlines()
    branches = [branch.strip() for branch in remote_branches]
    branches = [branch.replace('origin/', '') for branch in branches if 'origin/' in branch]
    return branches


def merge_and_accept_both(branch_name):
    print(" Fetch the latest changes from the remote repository")
    subprocess.run(['git', 'fetch'])
    print(" Checkout the branch where you want to merge changes")
    subprocess.run(['git', 'checkout', branch_name])
    print(" Merge the changes from the master branch")
    subprocess.run(['git', 'merge', 'origin/master'])
    print(" Resolve conflicts by accepting both changes")
    subprocess.run(['git', 'checkout', '--ours', '--', '*'])
    subprocess.run(['git', 'checkout', '--theirs', '--', '*'])
    print(" Commit the merged changes")
    subprocess.run(['git', 'commit', '-m', 'Merge master into ' + branch_name])
    print(" Push the changes to the remote repository")
    subprocess.run(['git', 'push', 'origin', branch_name])


if __name__ == "__main__":
    remote_branches = get_remote_branches()
    for branch in remote_branches[:3]:
        print(f"branch = {branch}")
        merge_and_accept_both(branch)
