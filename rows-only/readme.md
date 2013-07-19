This directory contains an encapsulated downloader for just the rows,
assuming we already have lists of viewids.

## Errors
I'm downloading all error messages because that will allow us to figure
out which things are federating from where. This first sort of error message
means that the data are federated to this table rather than natively on
this portal.
    
    {
      "code" : "not_found",
      "error" : true,
      "message" : "Cannot find view with id bxfh-jivs"
    }

This second sort means that the data are not a table; they might be an
external dataset.

    {
      "code" : "invalid_request",
      "error" : true,
      "message" : "Can only get rows for tabular datasets."
    }
