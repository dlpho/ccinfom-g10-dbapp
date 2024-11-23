package model.entities;


import jakarta.persistence.*;

import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;
import model.enumerations.*;

@Entity
@Table(name = "equipment", schema = "diagnosticsdb")
public class Equipment {
    @Id
    @Column(name = "equip_name", nullable = false, length = 45)
    private String equipName;

    @Lob
    @Column(name = "location", nullable = false)
    private EquipmentLocation location;

    @Lob
    @Column(name = "`condition`", nullable = false)
    private EquipmentCondition condition;

    @Column(name = "maintenance_start")
    private Instant maintenanceStart;

    @Column(name = "maintenance_end")
    private Instant maintenanceEnd;

    @OneToMany(mappedBy = "equipName")
    private Set<Test> tests = new LinkedHashSet<>();

    public String getEquipName() {
        return equipName;
    }

    public void setEquipName(String equipName) {
        this.equipName = equipName;
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

    public Instant getMaintenanceStart() {
        return maintenanceStart;
    }

    public void setMaintenanceStart(Instant maintenanceStart) {
        this.maintenanceStart = maintenanceStart;
    }

    public Instant getMaintenanceEnd() {
        return maintenanceEnd;
    }

    public void setMaintenanceEnd(Instant maintenanceEnd) {
        this.maintenanceEnd = maintenanceEnd;
    }

    public Set<Test> getTests() {
        return tests;
    }

    public void setTests(Set<Test> tests) {
        this.tests = tests;
    }

}