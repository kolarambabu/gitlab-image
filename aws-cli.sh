echo "Installing AWS CLI"

AWSCLI_VERSION=${1:-"2.24.5"}
AWSCLI_ARCH=${2:-"x86_64"}

if $(uname -a | grep 'aarch'); then
   AWSCLI_ARCH="aarch64"
fi

curl -sL https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_ARCH}-${AWSCLI_VERSION}.zip -o "awscliv2.zip"
unzip awscliv2.zip

aws/install

rm -rf \
    awscliv2.zip \
    aws \
    /usr/local/aws-cli/v2/*/dist/aws_completer \
    /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
    /usr/local/aws-cli/v2/*/dist/awscli/examples