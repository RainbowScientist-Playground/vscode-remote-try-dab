# Testing Data API builder REST and GraphQL endpoints

# Just cmd + click / ctrl + click on the links to open them in your browser
# Check DAB health endpoint
http://localhost:5000

# Inspect REST endpoint using Swagger
http://localhost:5000/swagger/index.html

# Inspect GraphQL endpoint using Banana Cake Pop
http://localhost:5000/graphql

# Curl commands, just copy and paste them in your terminal
# Check API endpoint for Books and Authors entitiesnetstat -tuln | grep :5000
curl -s http://localhost:5000/api/Book | jq
curl -s http://localhost:5000/api/Author | jq

# Check API endpoint for Books and Authors entities, using $filter and jq to filter the output
curl -s "http://localhost:5000/api/Book?\$filter=title%20eq%20'Foundation'" | jq
curl -s http://localhost:5000/api/Author | jq '.value[0] | {id, first_name, last_name}'

# Check GraphQL endpoint for Books entity, query the first 2 books in ascending order by id
curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"query": "{ books(first: 2, orderBy: {id: ASC}) { items { id title } } }"}' \
    http://localhost:5000/graphql | jq

# Check GraphQL endpoint for Books entity (GetBooks), query the first 2 books in descending order by id using variables
curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"query": "query GetBooks($first: Int!) { books(first: $first) { items { id title } } }", "variables": {"first": 2}}' \
    http://localhost:5000/graphql | jq

# Check GraphQL endpoint for Authors entity, query the first 2 authors in ascending order by id
curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"query": "{ authors(first: 2, orderBy: {id: ASC}) { items { id first_name last_name } } }"}' \
    http://localhost:5000/graphql | jq