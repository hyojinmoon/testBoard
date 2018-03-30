package com.test.board.model;

public class sawonDTO {
	private int no;
	private String kor_Name;
	private String eng_Name;
	private String chn_Name;
	private String jumin_Nof;
	private String jumin_Nob;
	private String jumin;
	private String image;
	private String birth1;
	private String birth2;
	private String birth3;
	private String birth;
	private String sol_Flag;
	private String sex;
	private String marry_Flag;
	private String work_Year;
	private String payment_Type;
	private String desire_Dept;
	private String jop_Type;
	private String address;
	private String phone1;
	private String phone2;
	private String phone3;
	private String phone;
	private String email;
	private String tech_Lev;
	private String liquor;
	public sawonDTO() {
		super();
	}
	
	public sawonDTO(String kor_Name, String eng_Name, String chn_Name, String jumin_Nof, String jumin_Nob,
			String image, String birth1, String birth2, String birth3, String sol_Flag, String sex, String marry_Flag,
			String work_Year, String payment_Type, String desire_Dept, String jop_Type, String address, String phone1,
			String phone2, String phone3, String email, String tech_Lev, String liquor) {
		super();
		this.kor_Name = kor_Name;
		this.eng_Name = eng_Name;
		this.chn_Name = chn_Name;
		this.jumin_Nof = jumin_Nof;
		this.jumin_Nob = jumin_Nob;
		this.image = image;
		this.birth1 = birth1;
		this.birth2 = birth2;
		this.birth3 = birth3;
		this.sol_Flag = sol_Flag;
		this.sex = sex;
		this.marry_Flag = marry_Flag;
		this.work_Year = work_Year;
		this.payment_Type = payment_Type;
		this.desire_Dept = desire_Dept;
		this.jop_Type = jop_Type;
		this.address = address;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
		this.email = email;
		this.tech_Lev = tech_Lev;
		this.liquor = liquor;
	}

	public sawonDTO(int no, String kor_Name, String eng_Name, String chn_Name, String jumin_Nof, String jumin_Nob,
			String jumin, String image, String birth1, String birth2, String birth3, String birth, String sol_Flag,
			String sex, String marry_Flag, String work_Year, String payment_Type, String desire_Dept, String jop_Type,
			String address, String phone1, String phone2, String phone3, String phone, String email, String tech_Lev,
			String liquor) {
		super();
		this.no = no;
		this.kor_Name = kor_Name;
		this.eng_Name = eng_Name;
		this.chn_Name = chn_Name;
		this.jumin_Nof = jumin_Nof;
		this.jumin_Nob = jumin_Nob;
		this.jumin = jumin;
		this.image = image;
		this.birth1 = birth1;
		this.birth2 = birth2;
		this.birth3 = birth3;
		this.birth = birth;
		this.sol_Flag = sol_Flag;
		this.sex = sex;
		this.marry_Flag = marry_Flag;
		this.work_Year = work_Year;
		this.payment_Type = payment_Type;
		this.desire_Dept = desire_Dept;
		this.jop_Type = jop_Type;
		this.address = address;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
		this.phone = phone;
		this.email = email;
		this.tech_Lev = tech_Lev;
		this.liquor = liquor;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getKor_Name() {
		return kor_Name;
	}
	public void setKor_Name(String kor_Name) {
		this.kor_Name = kor_Name;
	}
	public String getEng_Name() {
		return eng_Name;
	}
	public void setEng_Name(String eng_Name) {
		this.eng_Name = eng_Name;
	}
	public String getChn_Name() {
		return chn_Name;
	}
	public void setChn_Name(String chn_Name) {
		this.chn_Name = chn_Name;
	}
	public String getJumin_Nof() {
		return jumin_Nof;
	}
	public void setJumin_Nof(String jumin_Nof) {
		this.jumin_Nof = jumin_Nof;
	}
	public String getJumin_Nob() {
		return jumin_Nob;
	}
	public void setJumin_Nob(String jumin_Nob) {
		this.jumin_Nob = jumin_Nob;
	}
	public String getJumin() {
		return jumin;
	}
	public void setJumin(String jumin) {
		this.jumin = jumin;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getBirth1() {
		return birth1;
	}
	public void setBirth1(String birth1) {
		this.birth1 = birth1;
	}
	public String getBirth2() {
		return birth2;
	}
	public void setBirth2(String birth2) {
		this.birth2 = birth2;
	}
	public String getBirth3() {
		return birth3;
	}
	public void setBirth3(String birth3) {
		this.birth3 = birth3;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getSol_Flag() {
		return sol_Flag;
	}
	public void setSol_Flag(String sol_Flag) {
		this.sol_Flag = sol_Flag;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getMarry_Flag() {
		return marry_Flag;
	}
	public void setMarry_Flag(String marry_Flag) {
		this.marry_Flag = marry_Flag;
	}
	public String getWork_Year() {
		return work_Year;
	}
	public void setWork_Year(String work_Year) {
		this.work_Year = work_Year;
	}
	public String getPayment_Type() {
		return payment_Type;
	}
	public void setPayment_Type(String payment_Type) {
		this.payment_Type = payment_Type;
	}
	public String getDesire_Dept() {
		return desire_Dept;
	}
	public void setDesire_Dept(String desire_Dept) {
		this.desire_Dept = desire_Dept;
	}
	public String getJop_Type() {
		return jop_Type;
	}
	public void setJop_Type(String jop_Type) {
		this.jop_Type = jop_Type;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTech_Lev() {
		return tech_Lev;
	}
	public void setTech_Lev(String tech_Lev) {
		this.tech_Lev = tech_Lev;
	}
	public String getLiquor() {
		return liquor;
	}
	public void setLiquor(String liquor) {
		this.liquor = liquor;
	}

	@Override
	public String toString() {
		return kor_Name + ","+ eng_Name + "," + chn_Name + ","
				+ jumin_Nof + "," + jumin_Nob + "," + image + "," + birth1 + ","
				+ birth2 + "," + birth3 + "," + sol_Flag + "," + sex + ","
				+ marry_Flag + "," + work_Year + "," + payment_Type + ","
				+ desire_Dept + "," + jop_Type + "," + address + "," + phone1 + ","
				+ phone2 + "," + phone3 + "," + email + "," + tech_Lev + "," + liquor;
	}
	
	
}
