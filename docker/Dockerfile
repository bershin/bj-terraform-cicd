FROM hashicorp/terraform:0.12.29
# RUN mkdir /terraform
COPY terraform /terraform
RUN apk add --no-cache git docker curl bash python3 jq && \
    curl https://sdk.cloud.google.com > /tmp/install.sh && \
    bash /tmp/install.sh --disable-prompts

ENV PATH="/root/google-cloud-sdk/bin:${PATH}"