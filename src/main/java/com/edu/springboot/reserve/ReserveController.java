package com.edu.springboot.reserve;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.springboot.doctor.DoctorDTO;
import com.edu.springboot.member.HoursDTO;
import com.edu.springboot.member.IMemberService;
import com.edu.springboot.member.MemberDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReserveController {
	
	@Autowired
	IReserveService reserveDAO;
	
	@Autowired
	IMemberService memberDAO;
	
	// 예약 진행 페이지로 이동
	@GetMapping("/reserve/proceed.do")
	public String proceedGet(Model model, HttpSession session, ReserveDTO reserveDTO) {
		ObjectMapper objectMapper = new ObjectMapper();
		
		// 예약할 병원: 기본정보 
		MemberDTO hospitalInfo  = reserveDAO.getHospital(reserveDTO);
		model.addAttribute("hospitalInfo", hospitalInfo);
		
		/**************************************************/
		// 예약할 병원: 영업시간정보
		// 병원의 근무요일,시간 정보
		List<HoursDTO> hospHoursList = memberDAO.selectHospHours(hospitalInfo.getId());
		// 병원의 근무시간 정보
		List<String> stringHospHoursList = hospHoursList.get(0).generateTimeSlots().stream()
            .map(LocalTime::toString)
            .collect(Collectors.toList());
		try {
			String hoursList = objectMapper.writeValueAsString(stringHospHoursList);
			// 병원의 근무시간 정보
			model.addAttribute("hoursList", hoursList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		/**************************************************/
		String[] weeks = new String[hospHoursList.size()];
		for (int i = 0; i < hospHoursList.size(); i++) {
		    HoursDTO hour = hospHoursList.get(i);
		    weeks[i] = hour.getWeek(); 
		}
		// js 배열로 사용하기 위한 작업
		String week = "";
		for(int i=0; i<weeks.length; i++) {
		if(i==0) 
			week += "'"+weeks[i]+"'";
		else 
			week += ",'"+weeks[i]+"'";
		}
		model.addAttribute("week", week);
		
		// 예약할 병원: 예약불가 시간
		// 해당하는 병원의 예약이 있는 시간
		List<ReserveDTO> reserveList = reserveDAO.getReservationInfo(null, hospitalInfo.getId()); // 해당 병원의 예약 목록
	    Map<String, List<String>> reserveMap = new HashMap<>();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    
	    for (ReserveDTO reserve : reserveList) {
	    	 String postdate = dateFormat.format(reserve.getPostdate()); // 예약 날짜를 년-월-일 형태로 
	         String posttime = reserve.getPosttime(); // 예약 시간 
	         
	         System.err.println("postdate: " + postdate + " | posttime: " + posttime + " | 해당 시간의 예약개수: " + reserveDAO.getReservationCount(hospitalInfo.getId(), postdate, posttime));
	         
	         /* 디버깅: 예약 제한 개수 변경하기 */
	         // 해당 날짜(postdate)에 예약내역이 3개 이상이면 예약불가능 or 병원이 예약을 막은 시간이면 불가능(admin)
	         if( (reserveDAO.getReservationCount(hospitalInfo.getId(), postdate, posttime) >= 3) || (reserveDAO.getReservationName(hospitalInfo.getId(), postdate, posttime).equals("admin"))) {
	        	 // 해당 날짜의 리스트가 존재하지 않으면 새로 생성
	        	 if (!reserveMap.containsKey(postdate)) {
	        		 reserveMap.put(postdate, new ArrayList<>());
	        	 }
	        	 
	        	 // 해당 날짜의 리스트에 posttime 추가
	        	 reserveMap.get(postdate).add(posttime);
	         }
	     }
	    try {
			objectMapper.writeValueAsString(reserveMap);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
	    
	    // reserveMap을 json으로 변경
	    String hospReserveMap = null;
	    try {
	    	hospReserveMap = objectMapper.writeValueAsString(reserveMap);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
	    model.addAttribute("hospReserveMap", hospReserveMap);
	    /**************************************************/
	    // 예약할 병원: 의사정보 
	    List<DoctorDTO> doctorInfo = reserveDAO.getDoctor(hospitalInfo.getId());
	    model.addAttribute("doctorInfo", doctorInfo);
	    
	    // 예약하는 개인회원 정보
	    MemberDTO userInfo = memberDAO.loginMember((String)session.getAttribute("userId"),(String)session.getAttribute("userPassword"));
	    model.addAttribute("userInfo", userInfo);
	    
	    // 개인회원 정보 - 전화번호
	    String tel = userInfo.getTel();
	    String tel1 = tel.substring(0,3);
	    String tel2 = tel.substring(4,8);
	    String tel3 = tel.substring(9,13);
	    model.addAttribute("tel1", tel1);
	    model.addAttribute("tel2", tel2);
	    model.addAttribute("tel3", tel3);
	    
	    
	    // 개인회원 정보 - 주민등록번호
	    String rrn = userInfo.getRrn();
	    String birthRrn = rrn.substring(0, 6); 
	    String genderRrn = rrn.substring(7, 8); 
	    model.addAttribute("birthRrn", birthRrn);
	    model.addAttribute("genderRrn", genderRrn);
	    
	    return "reserve/proceed";
	    }
		
	
	// 예약하기
	@PostMapping("/reserve/proceed.do")
	public String proceedPost(Model model, ReserveDTO reserveDTO, HttpServletRequest req) {
		String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
		String rrn = req.getParameter("rrn1") + "-" + req.getParameter("rrn2") + "000000";
		
		reserveDTO.setTel(tel);
		reserveDTO.setRrn(rrn);
		
		
		// 예약정보 저장
		int reserveResult = reserveDAO.saveReservationInfo(reserveDTO);
		
		if(reserveResult ==1) {
			// 예약에 성공하면
			model.addAttribute("reserveDTO", reserveDTO);
			return "reserve/complete";
		} else {
			// 예약에 실패하면
			return "reserve/error";
		}
	}




	
	// 예약 취소하기
	@PostMapping("/reserve/cancel.do")
	public String cancel(Model model, HttpSession session, ReserveDTO reserveDTO) {
		reserveDAO.cancelReservation(reserveDTO);
		
		return "redirect:/myReserve.do";
	}
	
	// 예약 내역 숨김 (user)
	@GetMapping("/reserve/delete.do")
	public String delete(ReserveDTO reserveDTO) {
		reserveDAO.hideReservation(reserveDTO);
		
		return "redirect:/myReserve.do";
	}
	
	// 예약 시간 설정
	@GetMapping("/reserve/setTime.do")
	public String setTimeGet(Model model, HttpSession session, ReserveDTO reserveDTO, MemberDTO memberDTO) {
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		// 병원정보
		memberDTO.setId((String)session.getAttribute("userId"));
		MemberDTO hospitalInfo  = reserveDAO.getMyHospital(memberDTO);
		model.addAttribute("hospitalInfo", hospitalInfo);
		
		// 병원의 근무요일,시간 정보
		List<HoursDTO> hospHoursList = memberDAO.selectHospHours(hospitalInfo.getId());
		// 병원의 근무시간 정보
		List<String> stringHospHoursList = hospHoursList.get(0).generateTimeSlots().stream()
            .map(LocalTime::toString)
            .collect(Collectors.toList());
		try {
			String hoursList = objectMapper.writeValueAsString(stringHospHoursList);
			// 병원의 근무시간 정보
			model.addAttribute("hoursList", hoursList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		String[] weeks = new String[hospHoursList.size()];
		for (int i = 0; i < hospHoursList.size(); i++) {
		    HoursDTO hour = hospHoursList.get(i);
		    weeks[i] = hour.getWeek(); 
		}
		// js 배열로 사용하기 위한 작업
		String week = "";
		for(int i=0; i<weeks.length; i++) {
		if(i==0) 
			week += "'"+weeks[i]+"'";
		else 
			week += ",'"+weeks[i]+"'";
		}
		model.addAttribute("week", week);
		
		// 예약목록
		List<ReserveDTO> reserveList = reserveDAO.getReservationInfo(null, hospitalInfo.getId());
	    Map<String, List<String>> reserveMap = new HashMap<>();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    
	    for (ReserveDTO reserve : reserveList) {
	    	 String postdate = dateFormat.format(reserve.getPostdate());
	         String posttime = reserve.getPosttime();
	         
	         // 해당 날짜의 리스트가 존재하지 않으면 새로 생성
	         if (!reserveMap.containsKey(postdate)) {
	             reserveMap.put(postdate, new ArrayList<>());
	         }
	         
	         // 해당 날짜의 리스트에 posttime 추가
	         reserveMap.get(postdate).add(posttime);
	     }
	    try {
			objectMapper.writeValueAsString(reserveMap);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
	    
	    String hospReserveMap = null;
	    try {
	    	hospReserveMap = objectMapper.writeValueAsString(reserveMap);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
	    model.addAttribute("hospReserveMap", hospReserveMap);

		return "reserve/setTime";
	}
	@PostMapping("/reserve/setTime.do")
	public String setTimePost(HttpServletRequest req, ReserveDTO reserveDTO, RedirectAttributes redirectAttributes) {
		String[] posttimez = req.getParameterValues("posttimez");
		String action = req.getParameter("action"); 
		
		int setCloseTime;
		int setOpenTime;
		// 예약 닫기
		if (action.equals("close")) {
			for (int i = 0; i < posttimez.length; i++) {
				reserveDTO.setPosttime(posttimez[i]);
				setCloseTime = reserveDAO.closeTime(reserveDTO);
			}
		}
		// 예약 열기
		else {
			for (int i = 0; i < posttimez.length; i++) {
				reserveDTO.setPosttime(posttimez[i]);
				System.err.println(reserveDTO);
				setOpenTime = reserveDAO.openTime(reserveDTO);
				System.err.println("setOpenTime 결과: " + setOpenTime);
			}
		}
		
	    redirectAttributes.addFlashAttribute("setTimeResult", "예약 시간 설정이 완료되었습니다.");
		return "redirect:/reserve/setTime.do";
	}
	
}

