# setup cert with:
#
#fargate certificate request far1.andyt.work --region eu-west-1
#fargate certificate validate far1.andyt.work --region eu-west-1
fargate certificate info far1.andyt.work --region eu-west-1
#sleep 120
#
fargate lb create myapp --port 443 --certificate far1.andyt.work --region eu-west-1 --region eu-west-1
# next command builds from local Dockerfile & pushes
fargate service create myapp --port HTTP:80 --lb myapp --num 3 --region eu-west-1  
fargate lb info myapp --region eu-west-1
#faregate service logs app --follow --region eu-west-1
fargate lb alias myapp far1.andyt.work --region eu-west-1

fargate service info myapp --region eu-west-1
fargate service info myapp --region eu-west-1 | grep DNS
echo "fargate service info myapp --region eu-west-1"
#
#delete using:
#
#fargate service scale myapp 0 --region eu-west-1
#fargate service destroy myapp --region eu-west-1
#fargate lb destroy myapp --region eu-west-1

