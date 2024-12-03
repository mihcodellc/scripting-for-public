#!/bin/bash

echo "Listing all shared folders on the system:"

# Function to list Samba shares
list_samba_shares() {
    local smb_conf="/etc/samba/smb.conf"
    if [[ -f $smb_conf ]]; then
        echo "Samba Shares:"
        awk '
        /^\[.*\]/ {share_name=$0} 
        /path =/ {print "Alias: " share_name, "-> Path:", $3}
        ' "$smb_conf"
    else
        echo "Samba configuration file not found at $smb_conf."
    fi
}

# Function to list NFS shares
list_nfs_shares() {
    local exports_file="/etc/exports"
    if [[ -f $exports_file ]]; then
        echo "NFS Shares:"
        awk '
        {
            printf("Path: %s -> Shared with: %s\n", $1, $2)
        }' "$exports_file"
    else
        echo "NFS exports file not found at $exports_file."
    fi
}

# Run both functions
list_samba_shares
echo
list_nfs_shares
