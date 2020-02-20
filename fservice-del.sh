fargate service scale myapp 0 --region eu-west-1
fargate service destroy myapp --region eu-west-1
fargate lb destroy myapp --region eu-west-1

# $ npm install -g http-server   # install dependency
# $ http-server -p 8000