 package icbs.tellering

 class TxnPassbookLine {
     String pbCode
     String pbLine

     static constraints = {
         pbCode nullable:true
         pbLine nullable:true
     }
 }