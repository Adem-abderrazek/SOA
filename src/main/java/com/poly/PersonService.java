package com.poly;
import java.util.List;

public interface PersonService {
    public List<Person> getAllPersons();
    public boolean addPerson(Person p);
    public boolean deletePerson(int id);
    public Person getPerson(int id);
    public boolean updatePerson(Person p);
    public Person getPersonByName(String name);
}