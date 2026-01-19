package com.poly;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.HashMap;
import java.util.List;

@Path("/users")
public class RestRouter {

    PersonServiceImpl p = new PersonServiceImpl();

    // GET ALL - RETOURNE DIRECTEMENT LA LISTE
    @GET
    @Path("/affiche")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getAllUser() {
        return p.getAllPersons();
    }

    // ADD - CORRIGÉ POUR RETOURNER L'ID
    @PUT
    @Path("/add/{age}/{name}")
    @Produces(MediaType.APPLICATION_JSON)
    public HashMap<String, Object> addUser(@PathParam("age") int age,
                                           @PathParam("name") String name) {
        HashMap<String, Object> hashMap = new HashMap<>();
        try {
            Person user = new Person();
            user.setAge(age);
            user.setName(name);
            boolean success = p.addPerson(user);

            if (success) {
                hashMap.put("state", "ok");
                // Retourner l'ID de la personne ajoutée
                hashMap.put("id", user.getId());
                hashMap.put("name", user.getName());
                hashMap.put("age", user.getAge());
                hashMap.put("message", "Person added successfully");
            } else {
                hashMap.put("state", "error");
                hashMap.put("message", "Failed to add person");
            }
        } catch (Exception e) {
            hashMap.put("state", "error");
            hashMap.put("message", e.getMessage());
        }
        return hashMap;
    }

    // DELETE
    @DELETE
    @Path("/remove/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public HashMap<String, Object> deleteUser(@PathParam("id") int id) {
        HashMap<String, Object> hashMap = new HashMap<>();
        try {
            if (p.deletePerson(id)) {
                hashMap.put("state", "ok");
                hashMap.put("message", "Person deleted successfully");
            } else {
                hashMap.put("state", "error");
                hashMap.put("message", "Person with id " + id + " doesn't exist");
            }
        } catch (Exception e) {
            hashMap.put("state", "error");
            hashMap.put("message", e.getMessage());
        }
        return hashMap;
    }

    // GET BY ID
    @GET
    @Path("/getid/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public HashMap<String, Object> getIdUser(@PathParam("id") int id) {
        HashMap<String, Object> hashMap = new HashMap<>();
        try {
            Person person = p.getPerson(id);
            if (person != null) {
                hashMap.put("state", "ok");
                hashMap.put("data", person);
            } else {
                hashMap.put("state", "error");
                hashMap.put("message", "Person with id " + id + " doesn't exist");
            }
        } catch (Exception e) {
            hashMap.put("state", "error");
            hashMap.put("message", e.getMessage());
        }
        return hashMap;
    }

    // UPDATE
    @PUT
    @Path("/update/{id}/{age}/{name}")
    @Produces(MediaType.APPLICATION_JSON)
    public HashMap<String, Object> updateUser(@PathParam("id") int id,
                                              @PathParam("age") int age,
                                              @PathParam("name") String name) {
        HashMap<String, Object> hashMap = new HashMap<>();
        try {
            Person user = new Person();
            user.setId(id);
            user.setAge(age);
            user.setName(name);

            if (p.updatePerson(user)) {
                hashMap.put("state", "ok");
                hashMap.put("message", "Person updated successfully");
                hashMap.put("data", user);
            } else {
                hashMap.put("state", "error");
                hashMap.put("message", "Person with id " + id + " doesn't exist");
            }
        } catch (Exception e) {
            hashMap.put("state", "error");
            hashMap.put("message", e.getMessage());
        }
        return hashMap;
    }

    // GET BY NAME - CORRIGÉ
    @GET
    @Path("/getname/{name}")
    @Produces(MediaType.APPLICATION_JSON)
    public HashMap<String, Object> getNameUser(@PathParam("name") String name) {
        HashMap<String, Object> hashMap = new HashMap<>();
        try {
            Person person = p.getPersonByName(name);
            if (person != null) {
                hashMap.put("state", "ok");
                hashMap.put("data", person);
            } else {
                hashMap.put("state", "error");
                hashMap.put("message", "Person with name '" + name + "' doesn't exist");
            }
        } catch (Exception e) {
            hashMap.put("state", "error");
            hashMap.put("message", e.getMessage());
        }
        return hashMap;
    }

    // TEST ENDPOINT
    @GET
    @Path("/test")
    @Produces(MediaType.TEXT_PLAIN)
    public String test() {
        return "API is working! Persons count: " + p.getAllPersons().size();
    }
}