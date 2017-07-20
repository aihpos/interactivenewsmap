#testing for one data source to pull headlines

# pull data from the news spreadsheet
# for testing purposes, just going to use NYT

nyt_apikey = "3e32920893dc4ed3a3859b1627a4851a"
URL = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json"

# so the way the NYT API works, it returns 20 articles each time based on an offset
# offsets must be in multiples of 20
# also returns the total number of results (we're scraping these presumably daily)
# this time it returned 1404 results so we want to do a loop that does 1404/20 = 70.2 (71) collections

# request all articles so we can view the total # of articles and figure out how many loops we need

# initialize articles.full so it can be used to rbind data frame in for loop
articles.full <- NA

nyt_url = sprintf("%s?api-key=%s", URL, nyt_apikey)
articles <- GET(nyt_url)
articles <- fromJSON(content(articles, as = "text"))

# first article request to view # of articles
num_of_articles <- articles$num_results

# calculate number of loops to do
# as.integer rounds down but that's ok since the offset starts at 0 and not 20
endloop <- as.integer(num_of_articles / 20)

# filter out articles without geo facet tag
articles <- subset(articles$results, !(geo_facet == ""))

# adds the current batch of articles to the full articles dataframe
articles.full <- data.frame(articles)

# *** IMPORTANT
# sometimes when I run this for loop it returns an error:
# No encoding supplied: defaulting to UTF-8.
# Error: parse error: premature EOF
# (right here) ------^

# need to figure out what causes this/how to fix it
  
for (x in 1:endloop){
  # for every 20 articles
  
  print(x)
  
  #set actual article offset
  offset <- as.integer(20*x)
  
  nyt_url = sprintf("%s?offset=%d&api-key=%s", URL, offset, nyt_apikey)
  articles <- GET(nyt_url)
  articles <- fromJSON(content(articles, as = "text"))
  
  # filter out articles without geo facet tag
  articles <- subset(articles$results, !(geo_facet == ""))
  
  # adds the current batch of articles to the full articles dataframe
  articles.full <- rbind(articles.full,data.frame(articles))
  
}

# at this point, dataframe named "articles.full" is now populated with the daily articles
# that have a geotag associated with them. there's a lot of extra columns in there but I'm
# really sleepy so I'll do the rest tomorrow