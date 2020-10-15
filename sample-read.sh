# echo "paste csr : "
# IFS= read -d '' -n1 CERT_FILE
# while IFS= read -d '' -n 1 -t 2 c
# do
#     CERT_FILE+=$c
# done
# echo "CERT FILE"
# echo $CERT_FILE > cert

echo "enter the input CSR"
while read CSR
do
    cert="${CSR}"
done < CSR

echo "other processing continues "