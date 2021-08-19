FROM hashicorp/terraform:0.12.29
COPY terraform-network /terraform-network
COPY terraform /terraform
COPY tfvars /tfvars
COPY scripts /scripts
RUN apk add --no-cache git docker curl bash python3 jq && \
    curl https://sdk.cloud.google.com > /tmp/install.sh && \
    bash /tmp/install.sh --disable-prompts && \
    chmod 755 /scripts/*

ENV PATH="/root/google-cloud-sdk/bin:${PATH}"