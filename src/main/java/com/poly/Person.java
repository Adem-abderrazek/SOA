package com.poly;

public class Person {
    private int id;
    private String name;
    private int age;

    // Constructeur par défaut (IMPORTANT pour JSON)
    public Person() {
    }

    // Constructeur avec paramètres
    public Person(int id, String name, int age) {
        this.id = id;
        this.name = name;
        this.age = age;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
        System.out.println("DEBUG: Person ID set to: " + id);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
        System.out.println("DEBUG: Person name set to: " + name);
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
        System.out.println("DEBUG: Person age set to: " + age);
    }

    @Override
    public String toString() {
        return String.format("Person{id=%d, name='%s', age=%d}", id, name, age);
    }
}