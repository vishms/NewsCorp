#Check the correctness of the input arguments                                                                                                                           
if [ $# -ne 3 ]                                                                                                                                                         
then                                                                                                                                                                    
echo "Incorrect execution                                                                                                                                               
Expected format:                                                                                                                                                        
replaceTokens.sh <inputFile> <propertiesFile> <outputFile>                                                                                                              
Where all files have relative or absolute path along with file name"                                                                                                    
exit                                                                                                                                                                    
fi                                                                                                                                                                      
                                                                                                                                                                        
# take the arguments into a readable variables                                                                                                                          
inputFile=$1                                                                                                                                                            
propertyFile=$2                                                                                                                                                         
outputFile=$3

#source the property file to set the properties                                                                                                                         
source $propertyFile                                                                                                                                                    
                                                                                                                                                                        
#create the output file if the file already present then truncate the content                                                                                           
echo "" > $outputFile                                                                                                                                                   
                                                                                                                                                                        
#check if the file is successfully created.                                                                                                                             
#in case of failure in file creation then terminate this script                                                                                                         
if [ ! -f $outputFile ]                                                                                                                                                 
then                                                                                                                                                                    
echo "output file can not be created. Script terminating!!"                                                                                                             
exit                                                                                                                                                                    
fi

#read the file line by line and replace the tokens if necessary
# and write the transformed line to output                                                                                                       
                                                                                                                                                                        
IFS=$'\n'                                                                                                                                                               
for line in $(cat $inputFile)                                                                                                                                           
do                                                                                                                                                                      
toBeReplaced=`echo $line | grep -o '\[\[.*\]\]'`                                                                                                                        
if [ ! -z $toBeReplaced ]                                                                                                                                               
then                                                                                                                                                                    
tokenLen=`expr ${#toBeReplaced} - 4`                                                                                                                                    
token=${toBeReplaced:2:$tokenLen}                                                                                                                                       
temp='$'$token                                                                                                                                                          
echo $line | sed "s|\[\[$token\]\]|`eval "echo $temp"`|g" >> $outputFile                                                                                                
else                                                                                                                                                                    
echo $line >> $outputFile                                                                                                                                               
fi                                                                                                                                                                      
done                                                                                                                                                                    
                                                                                                                                                                        
                                                                                                                                                                        
echo "Input file is successfully Transformed. Please find the output file here: " $outputFile                                                                           
