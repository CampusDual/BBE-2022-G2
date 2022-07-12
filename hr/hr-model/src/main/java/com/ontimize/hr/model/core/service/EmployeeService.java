package com.ontimize.hr.model.core.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;

import com.ontimize.hr.api.core.service.IEmployeeService;
import com.ontimize.hr.model.core.dao.EmployeeDao;
import com.ontimize.hr.model.core.dao.EmployeeTypeDao;
import com.ontimize.hr.model.core.dao.UserDao;
import com.ontimize.hr.model.core.dao.UserRoleDao;
import com.ontimize.hr.model.core.service.utils.Utils;
import com.ontimize.jee.common.dto.EntityResult;
import com.ontimize.jee.common.dto.EntityResultMapImpl;
import com.ontimize.jee.common.exceptions.OntimizeJEERuntimeException;
import com.ontimize.jee.common.security.PermissionsProviderSecured;
import com.ontimize.jee.server.dao.DefaultOntimizeDaoHelper;

@Service("EmployeeService")
@Lazy
public class EmployeeService implements IEmployeeService {

	@Autowired
	private EmployeeDao employeeDao;

	@Autowired
	private EmployeeTypeDao employeeTypeDao;

	@Autowired
	private UserRoleDao userRoleDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private DefaultOntimizeDaoHelper daoHelper;

	@Override
	@Secured({ PermissionsProviderSecured.SECURED })
	public EntityResult employeeQuery(Map<String, Object> keyMap, List<String> attrList)
			throws OntimizeJEERuntimeException {
		return this.daoHelper.query(this.employeeDao, keyMap, attrList);

	}

	public int getHotelFromUser(String user) {
		List<String> columns = new ArrayList<>();
		columns.add(EmployeeDao.ATTR_HTL_ID);
		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(EmployeeDao.ATTR_USER, user);

		EntityResult result = this.daoHelper.query(employeeDao, keyMap, columns);
		if (result != null && result.getCode() != EntityResult.OPERATION_WRONG) {
			return Integer.parseInt(result.getRecordValues(0).get(EmployeeDao.ATTR_HTL_ID).toString());
		} else
			return -1;
	}

	public String getTypeFromUser(String user) {
		if (Utils.stringIsNullOrBlank(user))
			return null;
		List<String> columns = new ArrayList<>();
		columns.add(EmployeeDao.ATTR_TYPE_ID);
		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(EmployeeDao.ATTR_USER, user);

		EntityResult result = this.daoHelper.query(employeeDao, keyMap, columns);
		if (result != null && result.getCode() != EntityResult.OPERATION_WRONG) {
			if (result.calculateRecordNumber() == 1) {
				Integer typeID = (Integer) result.getRecordValues(0).get(EmployeeDao.ATTR_TYPE_ID);
				List<String> columnsType = new ArrayList<>();
				columnsType.add(EmployeeTypeDao.ATTR_NAME);
				Map<String, Object> keyMapType = new HashMap<>();
				keyMapType.put(EmployeeTypeDao.ATTR_ID, typeID);
				EntityResult resultType = this.daoHelper.query(employeeTypeDao, keyMapType, columnsType);
				if (resultType.calculateRecordNumber() == 1) {
					return resultType.getRecordValues(0).get(EmployeeTypeDao.ATTR_NAME).toString();
				} else
					return null;
			} else
				throw new IllegalArgumentException("USER IS NOT AN EMPLOYEE");

		} else
			return null;

	}

	public Integer getRoleFromEmployee(int employeeID) {
		List<String> columns = new ArrayList<>();
		columns.add(EmployeeDao.ATTR_TYPE_ID);
		Map<String, Object> keyMap = new HashMap<>();
		keyMap.put(EmployeeDao.ATTR_ID, employeeID);

		EntityResult result = this.daoHelper.query(employeeDao, keyMap, columns);
		if (result != null && result.getCode() != EntityResult.OPERATION_WRONG) {
			if (result.calculateRecordNumber() == 1) {
				Integer typeID = (Integer) result.getRecordValues(0).get(EmployeeDao.ATTR_TYPE_ID);
				List<String> columnsType = new ArrayList<>();
				columnsType.add(EmployeeTypeDao.ATTR_ROLE_ID);
				Map<String, Object> keyMapType = new HashMap<>();
				keyMapType.put(EmployeeTypeDao.ATTR_ID, typeID);
				EntityResult resultType = this.daoHelper.query(employeeTypeDao, keyMapType, columnsType);
				if (resultType.calculateRecordNumber() == 1) {
					return (Integer) resultType.getRecordValues(0).get(EmployeeTypeDao.ATTR_ROLE_ID);
				} else
					throw new IllegalArgumentException("EMPLOYEE TYPE ERROR");
			} else
				throw new IllegalArgumentException("INVALID EMPLOYEE ID");

		} else
			throw new IllegalArgumentException("INVALID EMPLOYEE ID");

	}

	@Override
	@Secured({ PermissionsProviderSecured.SECURED })
	public EntityResult employeeInsert(Map<String, Object> attrMap) throws OntimizeJEERuntimeException {

		try {

			if (!attrMap.containsKey(EmployeeDao.ATTR_NAME)) {
				return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "MISSING " + EmployeeDao.ATTR_NAME);
			} else {
				String name = attrMap.get(EmployeeDao.ATTR_NAME).toString();
				if (name.isBlank())
					return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
							EmployeeDao.ATTR_NAME + " IS BLANK");
			}

			if (!attrMap.containsKey(EmployeeDao.ATTR_SURNAME1)) {
				return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
						"MISSING " + EmployeeDao.ATTR_SURNAME1);
			} else {
				String surname = attrMap.get(EmployeeDao.ATTR_SURNAME1).toString();
				if (surname.isBlank())
					return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
							EmployeeDao.ATTR_SURNAME1 + " IS BLANK");
			}

			if (!attrMap.containsKey(EmployeeDao.ATTR_PHONE)) {
				return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "MISSING " + EmployeeDao.ATTR_PHONE);
			} else {
				String surname = attrMap.get(EmployeeDao.ATTR_PHONE).toString();
				if (surname.isBlank())
					return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
							EmployeeDao.ATTR_PHONE + " IS BLANK");
			}

			if (attrMap.containsKey(EmployeeDao.ATTR_EMAIL)) {
				if (!Utils.checkEmail(attrMap.get(EmployeeDao.ATTR_EMAIL).toString()))
					return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "INVALID EMAIL FORMAT");
			}

			if (!attrMap.containsKey(EmployeeDao.ATTR_IDENTIFICATION)) {
				return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
						"MISSING " + EmployeeDao.ATTR_IDENTIFICATION);
			} else {
				String surname = attrMap.get(EmployeeDao.ATTR_IDENTIFICATION).toString();
				if (surname.isBlank())
					return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
							EmployeeDao.ATTR_IDENTIFICATION + " IS BLANK");
			}

			if (attrMap.containsKey(EmployeeDao.ATTR_USER)) {
				String type = null;
				try {
					type= getTypeFromUser(daoHelper.getUser().getUsername());
					if (!Utils.stringsEquals(type, "Gerente"))
						attrMap.remove(EmployeeDao.ATTR_USER);						
				} catch (IllegalArgumentException e) {
					if (!Utils.stringsEquals("god",  daoHelper.getUser().getUsername()))
						attrMap.remove(EmployeeDao.ATTR_USER);
				}
				
				

			}
			return this.daoHelper.insert(this.employeeDao, attrMap);

		} catch (DuplicateKeyException e) {
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "DUPLICATE ERROR");

		}
	}

	@Override
	@Secured({ PermissionsProviderSecured.SECURED })
	public EntityResult employeeUpdate(Map<String, Object> attrMap, Map<String, Object> keyMap)
			throws OntimizeJEERuntimeException {

		try {

			if (!attrMap.containsKey(EmployeeDao.ATTR_NAME)) {
				return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "MISSING " + EmployeeDao.ATTR_NAME);
			} else {
				String name = attrMap.get(EmployeeDao.ATTR_NAME).toString();
				if (name.isBlank())
					return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
							EmployeeDao.ATTR_NAME + " IS BLANK");
			}

			if (!attrMap.containsKey(EmployeeDao.ATTR_SURNAME1)) {
				return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
						"MISSING " + EmployeeDao.ATTR_SURNAME1);
			} else {
				String surname = attrMap.get(EmployeeDao.ATTR_SURNAME1).toString();
				if (surname.isBlank())
					return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
							EmployeeDao.ATTR_SURNAME1 + " IS BLANK");
			}

			if (!attrMap.containsKey(EmployeeDao.ATTR_PHONE)) {
				return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "MISSING " + EmployeeDao.ATTR_PHONE);
			} else {
				String surname = attrMap.get(EmployeeDao.ATTR_PHONE).toString();
				if (surname.isBlank())
					return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
							EmployeeDao.ATTR_PHONE + " IS BLANK");
			}

			if (!attrMap.containsKey(EmployeeDao.ATTR_IDENTIFICATION)) {
				return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
						"MISSING " + EmployeeDao.ATTR_IDENTIFICATION);
			} else {
				String surname = attrMap.get(EmployeeDao.ATTR_IDENTIFICATION).toString();
				if (surname.isBlank())
					return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12,
							EmployeeDao.ATTR_IDENTIFICATION + " IS BLANK");
			}

			if (attrMap.containsKey(EmployeeDao.ATTR_EMAIL)
					&& !Utils.checkEmail(attrMap.get(EmployeeDao.ATTR_EMAIL).toString()))
				return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "INVALID EMAIL FORMAT");

			return this.daoHelper.update(this.employeeDao, attrMap, keyMap);

		} catch (DuplicateKeyException e) {
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "DUPLICATE EXCEPTION");

		}

	}

	@Override
	@Secured({ PermissionsProviderSecured.SECURED })
	public EntityResult employeeDelete(Map<String, Object> keyMap) throws OntimizeJEERuntimeException {
		return this.daoHelper.delete(this.employeeDao, keyMap);

	}

	@Override
	@Secured({ PermissionsProviderSecured.SECURED })
	public EntityResult employeeCreateUser(Map<String, Object> attrMap) throws OntimizeJEERuntimeException {
		if (!attrMap.containsKey("data"))
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "REQUEST CONTAINS NO DATA");
		Map<String, Object> data = (Map<String, Object>) attrMap.get("data");
		if (!data.containsKey(EmployeeDao.ATTR_ID))
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "MISSING EMPLOYEE ID");
		if (!data.containsKey(EmployeeDao.ATTR_USER))
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "MISSING USERNAME");
		if (!data.containsKey("qry_password"))
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "MISSING PASSWORD");
		Integer employeeId = Integer.parseInt(data.get(employeeDao.ATTR_ID).toString());
		String username = data.get(employeeDao.ATTR_USER).toString();
		String password = data.get("qry_password").toString();
		if (Utils.stringIsNullOrBlank(password))
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "PASSWORD IS BLANK");

		Integer roleID = null;
		try {
			roleID = getRoleFromEmployee(employeeId);
		} catch (IllegalArgumentException e) {
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, e.getMessage());
		}
		if (roleID == null)
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "ROLE NOT FOUND");

		Map<String, Object> attrMapUser = new HashMap<String, Object>();

		attrMapUser.put("user_", username);
		attrMapUser.put("password", password);

		try {
			daoHelper.insert(this.userDao, attrMapUser);
		} catch (DuplicateKeyException e) {
			return new EntityResultMapImpl(EntityResult.OPERATION_WRONG, 12, "USERNAME ALREADY IN USE");
		}
		Map<String, Object> attrMapUserRole = new HashMap<>();
		attrMapUserRole.put("id_rolename", roleID);
		attrMapUserRole.put("user_", username);
		return daoHelper.insert(userRoleDao, attrMapUserRole);
	}

}
