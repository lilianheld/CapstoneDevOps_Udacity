export AWS_ACCESS_KEY_ID=AKIAZS6E6WLWID64PBFY

export AWS_SECRET_ACCESS_KEY="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"

aws-iam-authenticator token -i [CLUSTERNAME]

# copy token and use for the next command

aws-iam-authenticator verify -t [TOKEN] -i [CLUSTERNAME]