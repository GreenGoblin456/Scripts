#!/bin/bash

KEYTAB="path_to_your_AD_generated_keytab"
PRINCIPAL="name_if_your_AD_user"
WORKGROUP="name_of_your_AD"
CCACHE="/tmp/krb5cc_adjoin"

# 1. Get Kerberos ticket using keytab and store it in a custom credential cache
KRB5CCNAME="$CCACHE" /usr/bin/kinit -kt "$KEYTAB" -r 7d "$PRINCIPAL"
if [ $? -ne 0 ]; then
    echo "$(date): kinit failed for $PRINCIPAL"
    exit 1
else
    /usr/bin/kinit nameofuser -kt path_to_your_AD_generated_keytab
fi

# 2. Use the custom credential cache to perform the domain join
KRB5CCNAME="$CCACHE" /usr/bin/net ads join -k -W "$WORKGROUP" --no-dns-updates
if [ $? -eq 0 ]; then
    echo "$(date): Successfully joined domain using $PRINCIPAL."
else
    echo "$(date): Failed to join domain using $PRINCIPAL."
fi

# 3. Clean up the credential cache (optional, for security)
rm -f "$CCACHE"

