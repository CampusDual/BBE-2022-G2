package com.ontimize.hr.model.core.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DataIntegrityViolationException;

import com.ontimize.hr.model.core.dao.BookingDetailsDao;
import com.ontimize.jee.common.dto.EntityResult;
import com.ontimize.jee.common.dto.EntityResultMapImpl;
import com.ontimize.jee.server.dao.DefaultOntimizeDaoHelper;

@ExtendWith(MockitoExtension.class)
class BookingDetailsServiceTest {

	@Mock
	private DefaultOntimizeDaoHelper daoHelper;

	@Mock
	private BookingDetailsDao bookingDetailsDao;

	@InjectMocks
	private BookingDetailsService service;

	@Test
	@DisplayName("Fails when you try insert without booking_id")
	void testBookingDetailsInsertBookingMandatory() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.BOOKING_MANDATORY);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("Fails when you try insert without details_type")
	void testBookingDetailsInsertDetailsTypeMandatory() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.DETAILS_TYPE_MANDATORY);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when you try insert without price")
	void testBookingDetailsInsertPriceMandatory() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.PRICE_MANDATORY);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when you try insert without paid")
	void testBookingDetailsInsertPaidMandatory() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.PAID_MANDATORY);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when you try insert without date")
	void testBookingDetailsInsertDateMandatory() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.DATE_MANDATORY);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when the price format is not correct in the insert")
	void testBookingDetailsInsertPriceErrorFormat() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.PRICE_FORMAT);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, "errorFormat");
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when the booking id format is not correct in the insert")
	void testBookingDetailsInsertBookingIdFormat() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.BOOKING_ID_FORMAT);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, "errorFormat");
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when the details type id format is not correct in the insert")
	void testBookingDetailsInsertDetailsTypeFormat() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.DETAILS_TYPE_FORMAT);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, "errorFormat");
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when the date format is not correct in the insert")
	void testBookingDetailsInsertParseDate() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.ERROR_PARSE_DATE);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "01/07/2022");

		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when the date is null in the insert")
	void testBookingDetailsInsertDateNull() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.ERROR_DATE_MANDATORY);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, null);
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		EntityResult er = service.bookingDetailsInsert(attrMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("Fails when you try to insert a booking that not exists")
	void testBookingDetailsInsertBookingNotExists() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.BOOKING_NOT_EXISTS);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		when(daoHelper.insert(bookingDetailsDao, attrMap)).thenThrow(new DataIntegrityViolationException("fk_bok_id"));

		EntityResult er = service.bookingDetailsInsert(attrMap);
		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());

	}

	@Test
	@DisplayName("Fails when you try to insert a details_type that not exists")
	void testBookingDetailsInsertDetailsTypeNotExists() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.DETAILS_TYPE_NOT_EXISTS);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		when(daoHelper.insert(bookingDetailsDao, attrMap)).thenThrow(new DataIntegrityViolationException(""));

		EntityResult er = service.bookingDetailsInsert(attrMap);
		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());

	}

	@Test
	@DisplayName("It fails when the booking_id format is not correct in the update")
	void testBookingDetailsUpdateBookingIdWrongFormat() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.BOOKING_ID_FORMAT);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, "wrongFormat");
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(BookingDetailsDao.ATTR_ID, 1);

		EntityResult er = service.bookingDetailsUpdate(attrMap, keyMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when the details_type format is not correct in the update")
	void testBookingDetailsUpdateTypeDetailsIdWrongFormat() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.DETAILS_TYPE_FORMAT);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, "wrongFormat");
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(BookingDetailsDao.ATTR_ID, 1);

		EntityResult er = service.bookingDetailsUpdate(attrMap, keyMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when the price format is not correct in the update")
	void testBookingDetailsUpdatePriceWrongFormat() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.PRICE_FORMAT);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, "wrongFormat");
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(BookingDetailsDao.ATTR_ID, 1);

		EntityResult er = service.bookingDetailsUpdate(attrMap, keyMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("It fails when the date format is not correct in the update")
	void testBookingDetailsUpdateErrorParseDate() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.ERROR_PARSE_DATE);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "01/07/2022");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(BookingDetailsDao.ATTR_ID, 1);

		EntityResult er = service.bookingDetailsUpdate(attrMap, keyMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("Fails when the date is null in the update")
	void testBookingDetailsUpdateDateNull() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.ERROR_DATE_MANDATORY);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, null);
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(BookingDetailsDao.ATTR_ID, 1);

		EntityResult er = service.bookingDetailsUpdate(attrMap, keyMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("Fails when booking_id doesn't exist in the update")
	void testBookingDetailsUpdateBookingNotExists() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.BOOKING_NOT_EXISTS);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(BookingDetailsDao.ATTR_ID, 1);

		when(daoHelper.update(bookingDetailsDao, attrMap, keyMap))
				.thenThrow(new DataIntegrityViolationException("fk_bok_id"));

		EntityResult er = service.bookingDetailsUpdate(attrMap, keyMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}

	@Test
	@DisplayName("Fails when details_type_id doesn't exist")
	void testBookingDetailsUpdateDetailsTypeNotExists() {
		EntityResult result = new EntityResultMapImpl();
		result.setCode(EntityResult.OPERATION_WRONG);
		result.setMessage(BookingDetailsService.DETAILS_TYPE_NOT_EXISTS);

		Map<String, Object> attrMap = new HashMap<>();
		attrMap.put(BookingDetailsDao.ATTR_BOOKING_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_TYPE_DETAILS_ID, 1);
		attrMap.put(BookingDetailsDao.ATTR_PRICE, 100.0);
		attrMap.put(BookingDetailsDao.ATTR_DATE, "2022-07-01");
		attrMap.put(BookingDetailsDao.ATTR_PAID, false);

		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(BookingDetailsDao.ATTR_ID, 1);

		when(daoHelper.update(bookingDetailsDao, attrMap, keyMap)).thenThrow(new DataIntegrityViolationException(""));

		EntityResult er = service.bookingDetailsUpdate(attrMap, keyMap);

		assertEquals(result.getCode(), er.getCode());
		assertEquals(result.getMessage(), er.getMessage());
	}
}
