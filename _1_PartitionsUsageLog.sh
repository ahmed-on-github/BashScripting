#! /usr/bin/bash

# Logging Partiotions with used size >= 90%
# Exit Status : 0: Success
# 		1: ?

# Write "df -kh" command results (Data about partitions) to a file
df -kh 2>/dev/null >./parts

# Read Number of partitions via "wc -l" and store it inside an env. var. Ignore its second o/p (filename)
NUMPARTS=$(wc -l ./parts | cut -d ' ' -f 1)

# 1st line produced from "df -kh" inside ./parts is to be removed ( Holds o/p column names)
NUMPARTS=$[ NUMPARTS - 1 ]


# Get partition names and % of usage by taking text before '%' (delimiter)
tail -${NUMPARTS} ./parts | cut -d '%' -f 1 > ./parts_usage

# Get partition mount points
tail -${NUMPARTS} ./parts | cut -d '%' -f 2 > ./parts_mount

# Get partition names
tail -${NUMPARTS} ./parts | cut -d ' ' -f 1 > ./parts_names

# --------------- Now let's get the usage percentage -------------
# Make Percantages at start of lines in new file in order to get them by cut ' ' safely by reversing file's lines
rev ./parts_usage > ./parts_usage.2

# Keep numbers/percentages only by cutting
cut -d ' ' -f 1 ./parts_usage.2 > ./parts_usage.3 

# Reverse numbers/percentages again to get correct values
rev ./parts_usage.3 > ./parts_usage.final

# Read partitions' file system types

# Configure log file 
LOGRULE="user.info,local1.info,user.notice,local1.notice                                                  /var/log/disk-usage.custom.a7md"
# Rule must be written inside a *.conf file if stored under /etc/rsyslog.d/ (Recommended)
sudo echo -e "# Logging Rule for Disk Usage Reporintg\n${LOGRULE} " > /etc/rsyslog.d/disk-usage.custom.a7md.conf
sudo systemctl restart rsyslog.service


# Now, run the logic to check each partition usage and log conditionally

for I in $( seq 1  ${NUMPARTS} )
do
	USAGE=$( tail -$[ NUMPARTS - I + 1 ] ./parts_usage.final | head -1)
	#echo $USAGE
	if [ $USAGE -ge 90 ] ; then
		PARTNAME=$( tail -$[ NUMPARTS - I + 1 ] ./parts_names | head -1  )
		PARTMOUNT=$( tail -$[ NUMPARTS - I + 1 ] ./parts_mount | head -1 ) 
		PARTFS=''
		
		# Ignore attached iso image file as it's full by default ( partition name starts with "sr")
		IS_SRx=$( echo ${PARTNAME} | grep -i ^sr | wc -c )
		
		#echo "is iso disk = ${IS_SRx}"
		
		# String Comparison uses == , numeric uses -eq	
		if  [ ${IS_SRx} -eq 0 ] ; then
			sudo logger -p 	user.info "Partition Space Warning: Name: ${PARTNAME}, Mount pt: ${PARTMOUNT}, Usage %: ${USAGE}, date/time: $(date)"
		fi	
	fi

done

exit 0 || exit $?
