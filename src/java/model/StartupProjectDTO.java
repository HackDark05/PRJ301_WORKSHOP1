/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;

public class StartupProjectDTO {
    private int project_id;
    private String project_name;
    private String description;
    private String status;
    private Date estimatedLaunch;
    
    public StartupProjectDTO() {
    }
    
    public StartupProjectDTO(int project_id, String project_name, String description, String status, Date estimatedLaunch) {
        this.project_id = project_id;
        this.project_name = project_name;
        this.description = description;
        this.status = status;
        this.estimatedLaunch = estimatedLaunch;
    }
    
    public int getProject_id() {
        return project_id;
    }
    
    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }
    
    public String getProject_name() {
        return project_name;
    }
    
    public void setProject_name(String project_name) {
        this.project_name = project_name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    // FIXED: Changed from getstatus() to getStatus()
    public String getStatus() {
        return status;
    }
    
    // FIXED: Changed from setstatus() to setStatus()
    public void setStatus(String status) {
        this.status = status;
    }
    
    // FIXED: Changed from getEstimatedLaunch() to getEstimated_launch()
    public Date getEstimated_launch() {
        return estimatedLaunch;
    }
    
    // FIXED: Changed from setEstimatedLaunch() to setEstimated_launch()
    public void setEstimated_launch(Date estimatedLaunch) {
        this.estimatedLaunch = estimatedLaunch;
    }
    
    @Override
    public String toString() {
        return "StartupProjectDTO{"
                + "project_id=" + project_id
                + ", project_name='" + project_name + '\''
                + ", description='" + description + '\''
                + ", status='" + status + '\''
                + ", estimatedLaunch=" + estimatedLaunch
                + '}';
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        StartupProjectDTO that = (StartupProjectDTO) obj;
        return project_id == that.project_id;
    }
    
    @Override
    public int hashCode() {
        return Integer.hashCode(project_id);
    }
}