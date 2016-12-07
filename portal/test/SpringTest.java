import org.apache.commons.codec.digest.DigestUtils;
import org.hibernate.SessionFactory;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.transaction.annotation.Transactional;

import com.web.controller.entity.User;


public class SpringTest {
	private ApplicationContext ac = new ClassPathXmlApplicationContext("config/spring-hibernate.xml");
	
	@Test
	@Transactional
	public void testSessionFactory() throws Exception{
		SessionFactory sessionFactory = (SessionFactory)ac.getBean("sessionFactory");
		System.out.println(sessionFactory);
		
	
//		UserService userService=(UserService)ac.getBean("UserService");
//		User user=userService.getById(69L);
//		user.setPassword(DigestUtils.md5Hex("admin1234"));
//		sessionFactory.getCurrentSession().save(user);
	}
	
}
