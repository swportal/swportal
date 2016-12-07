import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;




public class LogTest {
	private Log log = LogFactory.getLog(this.getClass());
	@Test
	public void test() throws Exception{
		log.debug("this is debug info");
		log.info("this is info info");
		log.warn("this is warn info");
		log.error("this is error info");
		log.fatal("this is fatal info");
	}
}
