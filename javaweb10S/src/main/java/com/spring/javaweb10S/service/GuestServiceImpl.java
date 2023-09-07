package com.spring.javaweb10S.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GuestServiceImpl implements GuestService {
	
	@Autowired
	com.spring.javaweb10S.dao.GuestDAO guestDAO;


}
