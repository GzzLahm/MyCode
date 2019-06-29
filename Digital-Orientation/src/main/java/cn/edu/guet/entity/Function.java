package cn.edu.guet.entity;

public class Function {
	private Integer id;
	private String privilegeName;
	private String url;
	private String generatemenu;//是否生成菜单，1：是 0：否
	private Integer zindex; //优先级
	private Integer pId; 
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPrivilegeName() {
		return privilegeName;
	}

	public void setPrivilegeName(String privilegeName) {
		this.privilegeName = privilegeName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getGeneratemenu() {
		return generatemenu;
	}

	public void setGeneratemenu(String generatemenu) {
		this.generatemenu = generatemenu;
	}

	public Integer getZindex() {
		return zindex;
	}

	public void setZindex(Integer zindex) {
		this.zindex = zindex;
	}


	public String getName() {
		return this.privilegeName;
	}
	public String getPage() {
		return this.url;
	}
	
	public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

	@Override
	public String toString() {
		return "Function [id=" + id + ", privilegeName=" + privilegeName + ", url=" + url + ", generatemenu="
				+ generatemenu + ", zindex=" + zindex + ", pId=" + pId + "]";
	}
	
}
