package com.poly;

import java.util.ArrayList;
import java.util.List;

public class PersonServiceImpl implements PersonService {


    private static List<Person> persons = new ArrayList<>();
    private static int idCounter = 1;

    @Override
    public List<Person> getAllPersons() {
      
        return persons;
    }

    @Override
    public boolean addPerson(Person p) {
        p.setId(idCounter++);
        persons.add(p);

        System.out.println("Person added: ID=" + p.getId()
                + ", Name=" + p.getName()
                + ", Age=" + p.getAge());
        System.out.println("Total persons: " + persons.size());

        return true;
    }

    @Override
    public boolean deletePerson(int id) {
        boolean removed = persons.removeIf(person -> person.getId() == id);
        if (removed) {
            System.out.println("Person with ID " + id + " deleted");
        }
        return removed;
    }

    @Override
    public Person getPerson(int id) {
        for (Person person : persons) {
            if (person.getId() == id) {
                System.out.println("Found person by ID " + id);
                return person;
            }
        }
        System.out.println("Person with ID " + id + " not found");
        return null;
    }

    @Override
    public boolean updatePerson(Person p) {
        for (Person person : persons) {
            if (person.getId() == p.getId()) {
                person.setName(p.getName());
                person.setAge(p.getAge());
                System.out.println("Person updated: ID=" + p.getId());
                return true;
            }
        }
        System.out.println("Person with ID " + p.getId() + " not found for update");
        return false;
    }

    @Override
    public Person getPersonByName(String name) {
        for (Person person : persons) {
            if (person.getName() != null &&
                    person.getName().equalsIgnoreCase(name)) {
                System.out.println("Found person by name '" + name + "'");
                return person;
            }
        }
        System.out.println("Person with name '" + name + "' not found");
        return null;
    }
}
