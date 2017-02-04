package com.web.controller.entity;



public class Education  implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private Long id;
	private String category;
	private String type;
	private String cateclass;
	private String contents;
	private String trainerName;
	private String department;
	private String schedule;
	private String duration;	
	private String trainee;
	private String traineeObject;
	private String traineeTotal;
	private String coverage;
	private String trainingTime;
	private String trainingDiffculty;
	private String trainerEvaluation;
	private String materials;
	private String filename;
	private String ip;
	private String uploadTime;
	public String getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}
		
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCateclass() {
		return cateclass;
	}
	public void setCateclass(String cateclass) {
		this.cateclass = cateclass;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getTrainerName() {
		return trainerName;
	}
	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getSchedule() {
		return schedule;
	}
	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getTrainee() {
		return trainee;
	}
	public void setTrainee(String trainee) {
		this.trainee = trainee;
	}
	public String getTraineeObject() {
		return traineeObject;
	}
	public void setTraineeObject(String traineeObject) {
		this.traineeObject = traineeObject;
	}
	public String getTraineeTotal() {
		return traineeTotal;
	}
	public void setTraineeTotal(String traineeTotal) {
		this.traineeTotal = traineeTotal;
	}
	public String getCoverage() {
		return coverage;
	}
	public void setCoverage(String coverage) {
		this.coverage = coverage;
	}
	public String getTrainingTime() {
		return trainingTime;
	}
	public void setTrainingTime(String trainingTime) {
		this.trainingTime = trainingTime;
	}
	public String getTrainingDiffculty() {
		return trainingDiffculty;
	}
	public void setTrainingDiffculty(String trainingDiffculty) {
		this.trainingDiffculty = trainingDiffculty;
	}
	public String getTrainerEvaluation() {
		return trainerEvaluation;
	}
	public void setTrainerEvaluation(String trainerEvaluation) {
		this.trainerEvaluation = trainerEvaluation;
	}
	public String getMaterials() {
		return materials;
	}
	public void setMaterials(String materials) {
		this.materials = materials;
	}
	
	
}
