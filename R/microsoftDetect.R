# See documentation at 
# https://learn.microsoft.com/en-us/azure/cognitive-services/translator/reference/v3-0-detect
microsoftDetect <-
  function(x, api.key, api.region){
    base_url <- "https://api.cognitive.microsofttranslator.com/detect"
    body <- data.frame(Text = x)
    query = list(
      "api-version" = "3.0"
    )
    response <- POST(
      base_url, 
      body = body,
      add_headers(
        "Ocp-Apim-Subscription-Key" = api.key,
        "Ocp-Apim-Subscription-Region" = api.region, ## Adding Region after getting back an error regarding the connection
        "Content-Type" = "application/json; charset=UTF-8"
      ),
      query = query,
      encode = "json"
    )
    httr::stop_for_status(response)
    contents <- httr::content(response)
    language_codes <- vapply(contents, function(x) x[["language"]][[1]], character(1L))
    return(language_codes)
    contents
    
  }
