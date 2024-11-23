import enumerations.EquipmentCondition;
import enumerations.EquipmentLocation;

import java.util.Date;
import java.util.List;

public class Equipment {
    private String equipment_name;
    private EquipmentLocation location;
    private EquipmentCondition condition;
    private Date maintenance_start;
    private Date maintenance_end;

    private List<Test> tests;

    public String getEquipment_name() {
        return equipment_name;
    }

    public void setEquipment_name(String equipment_name) {
        this.equipment_name = equipment_name;
    }

    public EquipmentLocation getLocation() {
        return location;
    }

    public void setLocation(EquipmentLocation location) {
        this.location = location;
    }

    public EquipmentCondition getCondition() {
        return condition;
    }

    public void setCondition(EquipmentCondition condition) {
        this.condition = condition;
    }

    public Date getMaintenance_start() {
        return maintenance_start;
    }

    public void setMaintenance_start(Date maintenance_start) {
        this.maintenance_start = maintenance_start;
    }

    public Date getMaintenance_end() {
        return maintenance_end;
    }

    public void setMaintenance_end(Date maintenance_end) {
        this.maintenance_end = maintenance_end;
    }

    public List<Test> getTests() {
        return tests;
    }

    public void setTests(List<Test> tests) {
        this.tests = tests;
    }
}
