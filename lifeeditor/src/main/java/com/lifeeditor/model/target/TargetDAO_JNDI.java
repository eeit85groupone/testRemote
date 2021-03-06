package com.lifeeditor.model.target;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.orm.hibernate3.HibernateTemplate;

import com.lifeeditor.model.achievement.AchievementVO;
import com.lifeeditor.model.sec_list.SecListVO;
import com.lifeeditor.model.target_list.Target_ListVO;
import com.lifeeditor.model.type_list.TypeListVO;
import com.lifeeditor.model.user_spec.user_specVO;
import com.lifeeditor.service.AchievementService;
import com.lifeeditor.service.SecListService;
import com.lifeeditor.service.Target_List_Service;
import com.lifeeditor.service.TypeListService;


public class TargetDAO_JNDI implements TargetDAO_interface {
	@SuppressWarnings("unused")
	private HibernateTemplate hibernateTemplate;    
    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) { 
        this.hibernateTemplate = hibernateTemplate;
    }

	private static DataSource ds = null;
	static {
		
		try {
			Context ctx = new InitialContext();
			ds= (DataSource) ctx.lookup("java:comp/env/jdbc/LE01");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public static final String GET_IDENTITY = "select @@IDENTITY AS 'result'";
	
	public  static final String INSERT_STMT = 
			"INSERT INTO target (trgName,typeID,sectionID,difficulty,intention,privacy,"
			+ "genkiBar,achID,priority,remindTimes,trgType,punishment,status,timeStart,timeFinish,doneTime) VALUES "
			+ "( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	public  static final String GET_ALL_STMT = 
			"SELECT targetID,trgName,typeID,sectionID,difficulty,intention,privacy,"
			+ "genkiBar,achID,priority,remindTimes,trgType,punishment,status,timeStart,timeFinish,doneTime "
			+ "FROM target where status = 2 ";
	public  static final String GET_ONE_STMT = 
			"SELECT targetID,trgName,typeID,sectionID,difficulty,intention,privacy,"
			+ "genkiBar,achID,priority,remindTimes,trgType,punishment,status,timeStart,timeFinish,doneTime "
			+ "FROM target where targetID = ?";
	
	public  static final String DELETE = 
			"DELETE FROM target where targetID = ?";
	
	public  static final String UPDATE = 
			"UPDATE target set trgName=?, typeID=?, sectionID=? , difficulty=? , intention=? , privacy=? , "
			+ "genkiBar=? , achID=? , priority=? , remindTimes=? , trgType=? , punishment=? , status=? , timeStart=? , "
			+ "timeFinish=? , doneTime=? where targetID = ?";
	
	public  static final String SEARCH_LIKE = " select * from target where trgType =1 and trgName like ?" ;

	public  static final String SHOW_OFFICIAL = "select t.trgName,ty.typeName,s.secName,t.intention,t.difficulty,t.timeFinish,t.typeID,t.sectionID,t.targetID" + 
												" from target t" +   
												" JOIN type_list ty ON ty.typeID = t.typeID" + 
												" JOIN sec_list s ON s.secID = t.sectionID" + 
												" where trgType =1 and timeFinish >= GETDATE()";
	
	public  static final String COUNT_NUMS_OF_TARGET_NAME = "SELECT COUNT(*) FROM target where trgName=? and trgType =2 ";
	
	public  static final String COUNT_RATES_OF_TARGET_NAME = "select convert(decimal(3,0),round((convert(decimal(2,0),   (SELECT COUNT(*) FROM target where trgName=? and trgType =2 and status = 3))/(SELECT COUNT(*) FROM target where trgName=? and trgType =2)  )*100,0))";
	
	public  static final String SHOW_ALL_CHALLENGE_NAME_FROM_USER = "SELECT trgName FROM target INNER JOIN target_list "+
	"ON target.targetID = target_list.targetID where userID = ? and trgType = 2 and timeFinish >= GETDATE()";

	private static final String GET_RANDOM_TARGET = "select top 1 * from (SELECT targetID, trgName, typeName, secName, " +
			 "intention, timeStart FROM sec_list INNER JOIN target ON sec_list.secID = target.sectionID INNER JOIN type_list ON" +
             " sec_list.typeID = type_list.typeID AND target.typeID = type_list.typeID where trgType =3 and timeFinish >= GETDATE()) t ORDER BY NEWID() ";
		
	private static final String GET_RANDOM_TARGET_ADVANCE = "select top 1 * from ( SELECT user_spec.lastName, user_spec.firstName, user_spec.userID, target.targetID, target.trgName, "+
			 " target.intention, sec_list.secName, type_list.typeName, target.timeStart FROM sec_list INNER JOIN target " +
			 " ON sec_list.secID = target.sectionID INNER JOIN target_list ON target.targetID = target_list.targetID INNER JOIN " +
			 " type_list ON sec_list.typeID = type_list.typeID AND target.typeID = type_list.typeID INNER JOIN " +
			 " user_spec ON target_list.userID = user_spec.userID  where trgType =3 )  t ORDER BY NEWID() " ;
	
	private static final String SEARCH_TARGET = "SELECT targetID, trgName, typeName, secName, intention, "
			+ "timeStart FROM sec_list INNER JOIN target ON sec_list.secID = target.sectionID INNER JOIN "
			+ "type_list ON sec_list.typeID = type_list.typeID AND target.typeID = type_list.typeID where trgType =3 and trgName like ?";
	
	private static final String SEARCH_TARGET_ADVANCE = "SELECT user_spec.lastName, user_spec.firstName, user_spec.userID, target.targetID , target.trgName, target.intention, sec_list.secName, type_list.typeName, target.timeStart"+
	" FROM sec_list INNER JOIN target ON sec_list.secID = target.sectionID INNER JOIN "+
	" target_list ON target.targetID = target_list.targetID INNER JOIN "+
	" type_list ON sec_list.typeID = type_list.typeID AND target.typeID = type_list.typeID INNER JOIN "+
	"user_spec ON target_list.userID = user_spec.userID  where trgType =3 and trgName like ?";
	
	private static final String CHECK = "UPDATE target SET status = 2 WHERE targetID = ?";
	private static final String COMPLETE = "UPDATE target SET status = 3,doneTime = GetDate() WHERE targetID = ?";
	
	
	
	@SuppressWarnings("resource")
	@Override
	public int insert(TargetVO TrgVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			
			pstmt.setString(1, TrgVO.getTrgName());
			pstmt.setInt(2, TrgVO.getTypeVO().getTypeID());
			if(TrgVO.getSectionVO() == null) {
				pstmt.setInt(3,java.sql.Types.INTEGER);
			}
			else
				pstmt.setInt(3, TrgVO.getSectionVO().getSecID());
			if(TrgVO.getDifficulty() != null)
				pstmt.setInt(4, TrgVO.getDifficulty());
			else
				pstmt.setNull(4, java.sql.Types.INTEGER);
			pstmt.setString(5, TrgVO.getIntention());
			if(TrgVO.getPrivacy() != null) 
				pstmt.setInt(6, TrgVO.getPrivacy());
			else
				pstmt.setNull(6, java.sql.Types.INTEGER);
			
			if(TrgVO.getGenkiBar() != null) 
				pstmt.setInt(7, TrgVO.getGenkiBar());
			else
				pstmt.setNull(7, java.sql.Types.INTEGER);
			
			AchievementVO achVO = TrgVO.getAchVO();
			if(achVO != null) {
				if(achVO.getAchID() != null) 
					pstmt.setInt(8, achVO.getAchID());
				else
					pstmt.setNull(8, java.sql.Types.INTEGER);
			}else
				pstmt.setNull(8, java.sql.Types.INTEGER);
			
			if(TrgVO.getPriority() != null) 
				pstmt.setInt(9, TrgVO.getPriority());
			else
				pstmt.setNull(9, java.sql.Types.INTEGER);
			
			if(TrgVO.getRemindTimes() != null) 
				pstmt.setInt(10, TrgVO.getRemindTimes());
			else
				pstmt.setNull(10, java.sql.Types.INTEGER);
			
			pstmt.setInt(11, TrgVO.getTrgType());
			
			if(TrgVO.getPunishment() != null) 
				pstmt.setInt(12, TrgVO.getPunishment());
			else
				pstmt.setNull(12, java.sql.Types.INTEGER);
			
			if(TrgVO.getStatus() != null) 
				pstmt.setInt(13, TrgVO.getStatus());
			else
				pstmt.setNull(13, java.sql.Types.INTEGER);

			pstmt.setDate(14, TrgVO.getTimeStart());
			pstmt.setDate(15, TrgVO.getTimeFinish());
			
			pstmt.setDate(16, TrgVO.getDoneTime());
//			if(TrgVO.getDoneTime() != null) 
//				pstmt.setDate(16, TrgVO.getDoneTime());
//			else
//				pstmt.setNull(16, java.sql.Types.DATE);
	
			pstmt.executeUpdate();
			
			pstmt = con.prepareStatement(GET_IDENTITY);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return result;
	}

	@Override
	public void update(TargetVO TrgVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, TrgVO.getTrgName());
			pstmt.setInt(2, TrgVO.getTypeVO().getTypeID());
			pstmt.setInt(3, TrgVO.getSectionVO().getSecID());
			pstmt.setInt(4, TrgVO.getDifficulty());
			pstmt.setString(5, TrgVO.getIntention());
			
			if(TrgVO.getPrivacy() != null) 
				pstmt.setInt(6, TrgVO.getPrivacy());
			else
				pstmt.setNull(6, java.sql.Types.INTEGER);
			
			if(TrgVO.getGenkiBar() != null) 
				pstmt.setInt(7, TrgVO.getGenkiBar());
			else
				pstmt.setNull(7, java.sql.Types.INTEGER);
			
			AchievementVO achVO = TrgVO.getAchVO();
			if(achVO.getAchID() != null) 
				pstmt.setInt(8, achVO.getAchID());
			else
				pstmt.setNull(8, java.sql.Types.INTEGER);
			
			if(TrgVO.getPriority() != null) 
				pstmt.setInt(9, TrgVO.getPriority());
			else
				pstmt.setNull(9, java.sql.Types.INTEGER);
			
			if(TrgVO.getRemindTimes() != null) 
				pstmt.setInt(10, TrgVO.getRemindTimes());
			else
				pstmt.setNull(10, java.sql.Types.INTEGER);
			
			pstmt.setInt(11, TrgVO.getTrgType());
			
			if(TrgVO.getPunishment() != null) 
				pstmt.setInt(12, TrgVO.getPunishment());
			else
				pstmt.setNull(12, java.sql.Types.INTEGER);
			
			if(TrgVO.getStatus() != null) 
				pstmt.setInt(13, TrgVO.getStatus());
			else
				pstmt.setNull(13, java.sql.Types.INTEGER);

			pstmt.setDate(14, TrgVO.getTimeStart());
			pstmt.setDate(15, TrgVO.getTimeFinish());
			
			pstmt.setDate(16, TrgVO.getDoneTime());
			
			
//			pstmt.setInt(6, TrgVO.getPrivacy());
//			pstmt.setInt(7, TrgVO.getGenkiBar());
//			AchievementVO achVO = TrgVO.getAchVO();
//			pstmt.setInt(8, achVO.getAchID());
//			pstmt.setInt(9, TrgVO.getPriority());
//			pstmt.setInt(10, TrgVO.getRemindTimes());
//			pstmt.setInt(11, TrgVO.getTrgType());
//			pstmt.setInt(12, TrgVO.getPunishment());
//			pstmt.setInt(13, TrgVO.getStatus());
//			pstmt.setDate(14, TrgVO.getTimeStart());
//			pstmt.setDate(15, TrgVO.getTimeFinish());
//			pstmt.setDate(16, TrgVO.getDoneTime());
			pstmt.setInt(17, TrgVO.getTargetID());
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void delete(Integer targetID) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, targetID);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public TargetVO findByPrimaryKey(Integer targetID) {
		
		TargetVO TrgVO = new TargetVO();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, targetID);
			
			rs = pstmt.executeQuery();
			AchievementService achSvc = new AchievementService();
		
			if(rs.next()) {
				
				
				TypeListService typeSvc = new TypeListService();
				SecListService secSvc = new SecListService();
				
				TrgVO.setTargetID(rs.getInt("targetID"));
				TrgVO.setTrgName(rs.getString("trgName"));
				TrgVO.setTypeVO(typeSvc.getOneUser(rs.getInt("typeID")));
				TrgVO.setSectionVO(secSvc.getOneUser(rs.getInt("sectionID")));
				TrgVO.setDifficulty(rs.getInt("difficulty"));
				TrgVO.setIntention(rs.getString("intention"));
				TrgVO.setPrivacy(rs.getInt("privacy"));
				TrgVO.setGenkiBar(rs.getInt("genkiBar"));
				TrgVO.setAchVO(achSvc.getOneAchmt(rs.getInt("achID")));
				TrgVO.setPriority(rs.getInt("priority"));
				TrgVO.setRemindTimes(rs.getInt("remindTimes"));
				TrgVO.setTrgType(rs.getInt("trgType"));
				TrgVO.setPunishment(rs.getInt("punishment"));
				TrgVO.setStatus(rs.getInt("status"));
				TrgVO.setTimeStart(rs.getDate("timeStart"));
				TrgVO.setTimeFinish(rs.getDate("timeFinish"));
				TrgVO.setDoneTime(rs.getDate("doneTime"));
					
			}	
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return TrgVO;
		
	}

	@Override
	public List<TargetVO> getAll() {
		
		List<TargetVO> list = new ArrayList<TargetVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			AchievementService achSvc = new AchievementService();
		    
			while(rs.next()) {
				
				TargetVO Trg = new TargetVO();
				Trg.setTargetID(rs.getInt("targetID"));
				Trg.setTrgName(rs.getString("trgName"));
				Trg.setDifficulty(rs.getInt("difficulty"));
				Trg.setIntention(rs.getString("intention"));
				Trg.setPrivacy(rs.getInt("privacy"));
				Trg.setGenkiBar(rs.getInt("genkiBar"));
				Trg.setAchVO(achSvc.getOneAchmt(rs.getInt("achID")));
				Trg.setPriority(rs.getInt("priority"));
				Trg.setRemindTimes(rs.getInt("remindTimes"));
				Trg.setTrgType(rs.getInt("trgType"));
				Trg.setPunishment(rs.getInt("punishment"));
				Trg.setStatus(rs.getInt("status"));
				Trg.setTimeStart(rs.getDate("timeStart"));
				Trg.setTimeFinish(rs.getDate("timeFinish"));
				Trg.setDoneTime(rs.getDate("doneTime"));
				list.add(Trg);
				
				
			}	
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
		
	}

	
	@Override
	public List<TargetVO> getAllofficial() {
		List<TargetVO> list = new ArrayList<TargetVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(SHOW_OFFICIAL);
			rs = pstmt.executeQuery();
			AchievementService achSvc = new AchievementService();
			TargetVO Trg = null;
			TypeListVO type = null;
			SecListVO sec = null;
			while(rs.next()) {
				Trg = new TargetVO();
				type = new TypeListVO();
				sec = new SecListVO();
				Trg.setTargetID(rs.getInt("targetID"));
				Trg.setTrgName(rs.getString("trgName"));
				type.setTypeID(rs.getInt("typeID"));
				type.setTypeName(rs.getString("typeName"));
				Trg.setTypeVO(type);
				sec.setSecID(rs.getInt("sectionID"));
				sec.setSecName(rs.getString("secName"));
				Trg.setSectionVO(sec);  
				Trg.setDifficulty(rs.getInt("difficulty"));
				Trg.setIntention(rs.getString("intention"));
				Trg.setTimeFinish(rs.getDate("timeFinish"));
				list.add(Trg);
				
				
			}	
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	
	
	@Override
	public List<TargetVO> findByKeyword(String keyword) {
		
		List<TargetVO> list = new ArrayList<TargetVO>();
		TargetVO TrgVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SEARCH_LIKE);
			
			pstmt.setString(1, "%" + keyword + "%");
			
			rs = pstmt.executeQuery();
			AchievementService achSvc = new AchievementService();
			
			while(rs.next()) {
				TrgVO = new TargetVO();

				TrgVO.setTargetID(rs.getInt("targetID"));
				TrgVO.setTrgName(rs.getString("trgName"));
				
				TypeListVO type = new TypeListVO();
				type.setTypeID(rs.getInt("typeID"));
				TrgVO.setTypeVO(type);
				
				SecListVO sec = new SecListVO();
				sec.setSecID(rs.getInt("sectionID"));
				TrgVO.setSectionVO(sec);  
				
				TrgVO.setDifficulty(rs.getInt("difficulty"));
				TrgVO.setIntention(rs.getString("intention"));
				TrgVO.setPrivacy(rs.getInt("privacy"));
				TrgVO.setGenkiBar(rs.getInt("genkiBar"));
				
				AchievementVO  achVO = new AchievementVO();
				achVO = achSvc.getOneAchmt(rs.getInt("achID"));
				achVO.setRewardPic(null);
				TrgVO.setAchVO(achVO);
				
				TrgVO.setPriority(rs.getInt("priority"));
				TrgVO.setRemindTimes(rs.getInt("remindTimes"));
				TrgVO.setTrgType(rs.getInt("trgType"));
				TrgVO.setPunishment(rs.getInt("punishment"));
				TrgVO.setStatus(rs.getInt("status"));
				TrgVO.setTimeStart(rs.getDate("timeStart"));
				TrgVO.setTimeFinish(rs.getDate("timeFinish"));
				TrgVO.setDoneTime(rs.getDate("doneTime"));
				list.add(TrgVO);
				
				
			}	
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	
	@Override
	public int countNumsOfTargetName(String keyword) {

		int result = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(COUNT_NUMS_OF_TARGET_NAME);
			
			pstmt.setString(1, keyword);
			rs = pstmt.executeQuery();
	
		
			if(rs.next()) {
				result = rs.getInt(1); 
				
					
			}	
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return result;
		
	}
	
	

	@Override
	public int countRateOfTargetName(String keyword) {
		int result = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(COUNT_RATES_OF_TARGET_NAME);
			
			pstmt.setString(1, keyword);
			pstmt.setString(2, keyword);
			rs = pstmt.executeQuery();
	
		
			if(rs.next()) {
				result = rs.getInt(1); 
				
					
			}	
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return result;
		
	}

	
	@Override
	public List<Target_ListVO> getFromKeyWordSearch(String keyword) {
		
		List<Target_ListVO> list = new ArrayList<Target_ListVO>();

		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SEARCH_TARGET_ADVANCE);
			pstmt.setString(1, "%" + keyword + "%");
			rs = pstmt.executeQuery();
			TargetVO Trg = null;
			TypeListVO type = null;
			SecListVO sec = null;
			user_specVO user = null;
			Target_ListVO trgList = null;
			
			while(rs.next()) {
				Trg = new TargetVO();
				type = new TypeListVO();
				sec = new SecListVO();
				user = new user_specVO();
				trgList = new Target_ListVO();
				user.setLastName(rs.getString("lastName"));
				user.setFirstName(rs.getString("firstName"));
			
				Trg.setTargetID(rs.getInt("targetID"));  
				Trg.setTrgName(rs.getString("trgName")); 
				
				type.setTypeName(rs.getString("typeName"));
				Trg.setTypeVO(type);
				sec.setSecName(rs.getString("secName"));
				Trg.setSectionVO(sec); 
				
				Trg.setIntention(rs.getString("intention"));
				Trg.setTimeFinish(rs.getDate("timeStart"));
				
				trgList.setUserVO(user);
				trgList.setTrgVO(Trg);			
				list.add(trgList);					
			}	
		
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	
	
	@Override
	public Target_ListVO getRandomTarget() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TargetVO Trg = null;
		TypeListVO type = null;
		Target_ListVO trgList = null;
		SecListVO sec = null;
		user_specVO user = null;
		
try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_RANDOM_TARGET_ADVANCE);
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				
//				Trg = new TargetVO();
//				type = new TypeListVO();
//				sec = new SecListVO();
//				Trg.setTargetID(rs.getInt("targetID"));
//				Trg.setTrgName(rs.getString("trgName"));
//				type.setTypeName(rs.getString("typeName"));
//				Trg.setTypeVO(type);
//				sec.setSecName(rs.getString("secName"));
//				Trg.setSectionVO(sec);  
//				Trg.setIntention(rs.getString("intention"));
//				Trg.setTimeFinish(rs.getDate("timeStart"));
				
				
				Trg = new TargetVO();
				type = new TypeListVO();
				sec = new SecListVO();
				user = new user_specVO();
				trgList = new Target_ListVO();
				user.setLastName(rs.getString("lastName"));
				user.setFirstName(rs.getString("firstName"));
			
				Trg.setTargetID(rs.getInt("targetID"));  
				Trg.setTrgName(rs.getString("trgName")); 
				
				type.setTypeName(rs.getString("typeName"));
				Trg.setTypeVO(type);
				sec.setSecName(rs.getString("secName"));
				Trg.setSectionVO(sec); 
				
				Trg.setIntention(rs.getString("intention"));
				Trg.setTimeFinish(rs.getDate("timeStart"));
				
				trgList.setUserVO(user);
				trgList.setTrgVO(Trg);			
					
			
			}	
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return trgList;
	}

	
	

	
	@Override
	public List<TargetVO> getAllChallengeNameFromUser(Integer userID) {

		List<TargetVO> list = new ArrayList<TargetVO>();
		TargetVO TrgVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SHOW_ALL_CHALLENGE_NAME_FROM_USER);	
			pstmt.setInt(1, userID);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TrgVO = new TargetVO();
				TrgVO.setTrgName(rs.getString("trgName"));
				list.add(TrgVO);
						
			}	
			
		} catch (SQLException e) {
			throw new RuntimeException("發生錯誤" + e.getMessage());
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt != null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	
		return list;
	}

	@Override
	public void check(Integer targetID) {
		Connection conn = null;
		try {
			conn = ds.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(CHECK);
			pstmt.setInt(1, targetID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	@Override
	public void complete(Integer targetID) {
		Connection conn = null;
		try {
			conn = ds.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(COMPLETE);
			pstmt.setInt(1, targetID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}





	
}
