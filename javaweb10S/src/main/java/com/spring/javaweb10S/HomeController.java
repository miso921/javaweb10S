package com.spring.javaweb10S;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb10S.service.AdminService;
import com.spring.javaweb10S.service.RecipeService;
import com.spring.javaweb10S.service.ShopService;
import com.spring.javaweb10S.vo.MainVO;
import com.spring.javaweb10S.vo.ProductVO;
import com.spring.javaweb10S.vo.RecipeVO;

@Controller
public class HomeController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	RecipeService recipeService;
	
	@Autowired
	AdminService adminService;

	
	@RequestMapping(value = {"/","/h"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
//		String[] homeImages = new String[3];
//		for(int i=0; i<recipeVOS.size(); i++) {
//			int no = (int)(Math.random()*(recipeVOS.size()-1));
//			String[] noImage = recipeVOS.get(no).getFile().split("/");
//			homeImages[i] = noImage[0];
//			if(i == 2) break;
//		}
//		for(String item : homeImages) {
//			System.out.println("homeImage : " + item);
//		}
		List<ProductVO> productVOS  = shopService.getItemList();
		List<RecipeVO> recipeVOS = recipeService.getRecipeList();
		model.addAttribute("productVOS",productVOS);
		model.addAttribute("recipeVOS",recipeVOS);

//		model.addAttribute("homeImages",homeImages);
		
		List<MainVO> mainVOS = adminService.getMainSetting();
		model.addAttribute("mainVOS",mainVOS);
		
		return "home";
	}
	
	// ckeditor 등록 처리
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/"); // 서버에 저장할 때 RealPath
		String oFileName = upload.getOriginalFilename();
//		System.out.println("realPath:"+realPath);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		// ckeditor에서 올린(전송)한 파일을 서버 파일시스템에 실제로 저장처리시켜준다.
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(bytes);
		
		// 서버 파일시스템에 저장되어 있는 그림파일을 브라우저 편집화면(textarea)에 보여주는 처리
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/resources/data/ckeditor/" + oFileName; // 브라우저에 띄울 때 getContextPath
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();		
		fos.close();
	}
	
	
	
	
	
	
	
	
	
	// 크롤링
//	public static void main(String[] args) {
//		WebElement webElement;
//		String title, article, photo, date;
//		
//		final File driverFile = new File("C:\\javaweb\\springframework\\javaweb10S\\javaweb10S\\src\\main\\resources\\chromedriver.exe");
//		final String driverFilePath = driverFile.getAbsolutePath();
//		if(!driverFile.exists() && driverFile.isFile()) {
//			throw new RuntimeException("not found file. or this is not file" + driverFilePath);
//		}
//		
//		final ChromeDriverService service;
//		service = new ChromeDriverService.Builder().usingDriverExecutable(driverFile).usingAnyFreePort().build();
//		ChromeOptions options = new ChromeOptions();
		// 브라우저가 눈에 보이지 않고 내부적으로 돈다.
		// 설정하지 않을 시 실제 크롬 창이 생성되고, 어떤 순서로 진행되는지 확인할 수 있다.
//		options.addArguments("headless");
		
		// 위에서 설정한 옵션은 담은 드라이버 객체 생성
		// 옵션을 설정하지 않았을 때에는 생략 가능하다.
		// WebDriver객체가 곧 하나의 브라우저 창이라 생각한다.
		
//		try {
//			service.start();
//		} catch(IOException e1) {
//			e1.printStackTrace();
//		}
		
		//final WebDriver driver = new ChromeDriver(options);
//		final WebDriver driver =  new ChromeDriver(service);
//		final WebDriverWait wait = new WebDriverWait(driver, 10);
		
//		try {
//			driver.get("https://www.joongang.co.kr/newsletter/cooking");
//			Thread.sleep(3000);
			
//			JavascriptExecutor js = (JavascriptExecutor) driver;
			
//            for (int i = 1; i <= 100; i++) {
//            	driver.findElement(By.xpath("/html/body/div[1]/main/section/section[1]/ul/li["+i+"]/div/h2/a")).click();
//            	Thread.sleep(2000);
//							/*
//							 * webElement = driver.findElement(By.xpath("//*[@id=\"d_song_org\"]/a/img"));
//							 * // image 요소 식별 photo = webElement.getAttribute("src"); // 이미지 URL 가져오기
//							 */
//            	webElement = driver.findElement(By.xpath("//*[@id=\"container\"]/section/article/header/div[2]"));
//            	title = webElement.getText();
//            	
//            	webElement = driver.findElement(By.xpath("/html/body/div[1]/main/section/article/div"));
//            	article = webElement.getText();
//            	
//            	webElement = driver.findElement(By.xpath("/html/body/div[1]/main/section/article/header/div[2]/div/input"));
//            	date = webElement.getText();
//            	
//            	System.out.println(
//            			i + " / Title: " + title + " / Article: " + article + " / date: " + date
//							/* + " / photo: " + photo */);
//            	
//            	driver.findElement(By.className("menu_bg")).click();
//            	
//            	driver.navigate().back();
//            	Thread.sleep(2000);
//            	
							/*
							 * // 다음 페이지로 이동하는 조건문 if(i % 24 == 0) { WebElement nextPageButton =
							 * driver.findElement(By.xpath(
							 * "//*[@id=\"container\"]/section/section[1]/nav/ul/li["+i+"]/a")); if
							 * (!nextPageButton.getAttribute("disabled").equals("true")) {
							 * nextPageButton.click(); Thread.sleep(2000); } else { break; } }
							 */
//            }
//			
//	    } catch (Exception e2) {
//	        e2.printStackTrace();
//	    } finally {
//	        // 프로그램이 종료되면 resource 해제
//	        driver.quit();
//	        service.stop();
//	    }
//	}

}
