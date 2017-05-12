package com.newscorp;

import org.apache.commons.lang3.StringUtils;

public class SubscriptionController {
	
	//set the default max length
	private int strLimit = 250;
	
	public void setStrLimit (int strLimit){
		this.strLimit = strLimit;
	}
	
	public String subscribe(String request ) {
		
		String truncatedOrderDetails = truncate(request, strLimit);
		System.out.println(truncatedOrderDetails);
	
		return "";
	}

	private String truncate(String request, int lenLimit) {
		return StringUtils.abbreviateMiddle(request, " ... (truncated) ... ", lenLimit);
	}

	public static void main(String[] args) {
		SubscriptionController obj = new SubscriptionController();
		
		obj.setStrLimit(25);
		obj.subscribe("123456789012345678901234567890");
		
		obj.setStrLimit(5);
		obj.subscribe("1234567890");


		obj.setStrLimit(31);
		obj.subscribe("123456789012345678901234567890");
	}

}
