# TwitterTrends

TwitterTrends is an app that uses the Twitter API to fetch trending topics based on a users current location.

The following process is followed in order to successfully retrieve Twitter's trending topics:
  - CoreLocation is used to fecth the users latitude and longitude
  - Twitter Consumer Key and Consumer Secret are encoded as per Twitter Requirements
  - The user is then authenticated by obtaining a bearer token from Twitter
  - We fetch the closest 'WOEID' from twitter based on users coordinates. This information is parsed for future use.
  - Twitter's trending topics are fetched and parsed
  - The view is updated to reflect successful or failed fetch request
  
Requirements:
  - Twitter Consumer Key
  - Twitter Consumer Secret
  - Head to https://apps.twitter.com/ to apply
  - Consumer Key and Consumer Secret need to be added to Constants to enable app functionality
