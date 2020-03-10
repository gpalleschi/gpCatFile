#
# gpCatFile.awk 1.1 by GPsoft 10/03/2020
#

# Function to check length array
function alen(a) {
    len = 0	 
    for(len in a);
    return len 
}

BEGIN {
  iLine = 0;
  iError = 0;
  version = "gpCatFile.awk Ver 1.1 by Giovanni Palleschi 2020-03-09 "
  if ( ARGC < 2 )
  {
     printf "\n\n%s",version
     print "\n\nThis program is used to visualize record (new line delimited) and its fields "
     print "using a file structure "
     print "\n\nRunning GPef with these parameter :"
     print "\n\n cat 'Input File' | awk -f gpCatFile.awk 'Name Structure File' "
     print "\n\nFormat Structure File (fields separated by ;) :"
     print "- Field Name "
     print "- Start Byte "
     print "- Length Field "
     print "- function "
     printf "\n\nV : To Show field "

     iError = 1;
     exit;
  }

  ind = 1;
  # Read structure file
  while(( getline line<ARGV[1]) > 0 ) {
    split(line, a, ";")
    if ( alen(a) != 4 )
    {
      printf "\n\nError line <%s> of file structure <%s> is in wrong format.\n\n",line,ARGV[1]
      iError = 1;
      exit;
    }
    #Array Field Name
    fstructN[ind] = a[1]
    #Array Field Start in Bytes
    fstructS[ind] = a[2]
    #Array Field Length in Bytes
    fstructL[ind] = a[3]
    #Array Function 
    fstructF[ind] = a[4]
    ind++
  }
  close(ARGV[1])

}
# Elaboration File
{
  while(( getline line<"/dev/stdin") > 0 ) {
    printf "RECORD : %d\n",++iLine
    for (i in fstructN)
    {
      if ( fstructF[i] == "V" )
      {	      
        printf("%s\t\t:\t'%s'\n",fstructN[i],substr(line,fstructS[i],fstructL[i]))
      }
    }
  }
}
END {
  if ( iError == 0 ) printf "\nTotal Records : %d\n",iLine
}
