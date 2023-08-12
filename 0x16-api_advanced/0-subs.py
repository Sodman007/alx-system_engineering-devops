#!/usr/bin/python3
"""
function that queries the Reddit API and returns the number of subscribers for a given subreddit.
"""
from requests import get

def number_of_subscribers(subreddit):
    """
    function that queries the Reddit API and returns the number of subscribers
    (not active users, total subscribers) for a given subreddit
    """

    if subreddit is None or not isinstance(subreddit, str):
        return 0

    user_agent= {'User-Agent': 'Chrome/42.0.2311.135'}
    url = 'https://www.reddit.com/r/{}/about.json'.format(subreddit)
    response = get(url, headers=user_agent, allow_redirects=False)

    try:
        return result.get('data').get('subscribers')
    except exception:
        return 0
