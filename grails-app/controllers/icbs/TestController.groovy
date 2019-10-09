package icbs



class TestController {
	
	def GlTransactionService

    def index() { }
    def batchTransactionsTest() {}
    
    def testService () 
    {
    	GlTransactionService.debitGlAccount('1-00-00-00-00-00',1000)
    }
}
