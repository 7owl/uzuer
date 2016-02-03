package com.lingtong.interfaces;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * @author xqq
 * @date 2015-9-18 下午9:04:04
 * 
 */
public interface UnlockService {
	/*
	 * @Path("/create/")
	 * 
	 * @POST
	 * 
	 * @Produces({MediaType.APPLICATION_FORM_URLENCODED}) Response
	 * create(@FormParam("unlock") String unlock);
	 */
	@Path("/create/")
	@POST
	@Produces({ MediaType.APPLICATION_FORM_URLENCODED })
	Response create(@FormParam("kid") Integer kid,
			@FormParam("adminKeyboardPs") String adminKeyboardPs,
			@FormParam("adminKeyboardPsTmp") String adminKeyboardPsTmp,
			@FormParam("aseKey") String aseKey,
			@FormParam("date") Double date,
			@FormParam("day10mPsIndex") Integer day10mPsIndex,
			@FormParam("day1PsIndex") Integer day1PsIndex,
			@FormParam("day2PsIndex") Integer day2PsIndex,
			@FormParam("day3PsIndex") Integer day3PsIndex,
			@FormParam("day4PsIndex") Integer day4PsIndex,
			@FormParam("day5PsIndex") Integer day5PsIndex,
			@FormParam("day6PsIndex") Integer day6PsIndex,
			@FormParam("day7PsIndex") Integer day7PsIndex,
			@FormParam("deletePs") String deletePs,
			@FormParam("deletePsTmp") String deletePsTmp,
			@FormParam("desc1") String desc1,
			@FormParam("doorName") String doorName,
			@FormParam("endDate") Double endDate,
			@FormParam("version") String version,
			@FormParam("username") String username,
			@FormParam("unlockFlag") Integer unlockFlag,
			@FormParam("startDate") Double startDate,
			@FormParam("roomid") Integer roomid,
			@FormParam("password") String password,
			@FormParam("mac") String mac,
			@FormParam("lockName") String lockName,
			@FormParam("lockmac") String lockmac,
			@FormParam("isShared") Integer isShared,
			@FormParam("isAdmin") Integer isAdmin,
			@FormParam("hasbackup") Integer hasbackup,
			@FormParam("uz_room_seq") String uz_room_seq,
			@FormParam("key") String key);

	@Path("/sendKey/")
	@POST
	@Produces({ MediaType.APPLICATION_FORM_URLENCODED })
	Response sendKey(@FormParam("roomSeq") String roomSeq);

	@Path("/getLockAndKey/")
	@POST
	@Produces({ MediaType.APPLICATION_FORM_URLENCODED })
	Response getLockAndKey(@FormParam("tenantid") String tenantid);
}
