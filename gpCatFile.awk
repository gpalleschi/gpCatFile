# gpCatFile.awk 1.0 by GPsoft 09/03/2020
#
BEGIN {
  iLine = 0;
  if ( ARGC < 2 )
  {
     print "\n\ngpCatFile.awk by Giovanni Palleschi 2020-03-09 Ver 1.0"
     print "\nThis program is used to extract record (new line delimited) apply rules to select them"
     print "\n\nRunning GPef with these parameter :"
     print "\n\n cat 'Input File' | awk -f gpCatFile.awk 'Name Structure File' "
     print "\n\nFormat Structure File (fields separated by ;) :"
     print "- Field Name "
     print "- Start Byte "
     print "- Length Field "
     exit;
  }

  ind = 1;
  # Read structure file
  while(( getline line<ARGV[1]) > 0 ) {
    split(line, a, ";")
    if ( length(a) != 3 )
    {
      printf "\n\nError line <%s> of file structure <%s> is in wrong format.\n\n",line,ARGV[1]
      exit;
    }
    #Array Field Name
    fstructN[ind] = a[1]
    #Array Field Start in Bytes
    fstructS[ind] = a[2]
    #Array Field Length in Bytes
    fstructL[ind] = a[3]
    ind++
  }
  close(ARGV[1])

}
# Elaboration File
{
  while(( getline line<"/dev/stdin") > 0 ) {
    printf "RECORD : %d\n",++iLine
    for (i = 1; i <= length(fstructN); i++)
    {
      printf("%s\t\t:\t'%s'\n",fstructN[i],substr(line,fstructS[i],fstructL[i]))
    }
  }
}
END {
  printf "\nTotal Records : %d\n",iLine
}
