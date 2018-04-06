package com.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SocialMediaDB {

    JDBCWrapper wrapper;

    public SocialMediaDB(JDBCWrapper w) {
        wrapper = w;
    }

    /*
    Name: getAllMembers
    Parameters: none
    Returns: ArrayList : Member
    Comments: Returns arraylist of Members
     */
    public ArrayList<String> getAllSwears() {
        ArrayList ret = new ArrayList<String>();
        wrapper.createStatement();
        wrapper.createResultSet("SELECT * FROM swears");
        try {
            wrapper.getResultSet().next();
            do {
                ret.add(wrapper.getResultSet().getString("swear"));
            } while (wrapper.getResultSet().next());
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }
    
    public ArrayList<Results> getAllResults() {
        ArrayList ret = new ArrayList<Results>();
        wrapper.createStatement();
        wrapper.createResultSet("SELECT * FROM results");
        try {
            wrapper.getResultSet().next();
            do {
                ret.add(new Results(wrapper.getResultSet().getString("ruleBase"), wrapper.getResultSet().getDouble("mutationRate"), wrapper.getResultSet().getInt("populationSize"), wrapper.getResultSet().getString("fitness")));
            } while (wrapper.getResultSet().next());
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    public ArrayList<String> getAllPositiveWords() {
        ArrayList ret = new ArrayList<String>();
        wrapper.createStatement();
        wrapper.createResultSet("SELECT * FROM positivewords");
        try {
            wrapper.getResultSet().next();
            do {
                ret.add(wrapper.getResultSet().getString("word"));
            } while (wrapper.getResultSet().next());
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    public ArrayList<String> getAllNegativeWords() {
        ArrayList ret = new ArrayList<String>();
        wrapper.createStatement();
        wrapper.createResultSet("SELECT * FROM negativewords");
        try {
            wrapper.getResultSet().next();
            do {
                ret.add(wrapper.getResultSet().getString("word"));
            } while (wrapper.getResultSet().next());
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    public ArrayList<Country> getAllCountries() {
        ArrayList<Country> ret = new ArrayList();
        wrapper.createStatement();
        wrapper.createResultSet("SELECT * FROM countries");
        try {
            wrapper.getResultSet().next();
            do {
                ret.add(new Country(wrapper.getResultSet().getString("code"), wrapper.getResultSet().getString("name"), wrapper.getResultSet().getString("continentcode")));
            } while (wrapper.getResultSet().next());
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    public ArrayList<State> getAllStates() {
        ArrayList<State> ret = new ArrayList();
        wrapper.createStatement();
        wrapper.createResultSet("SELECT * FROM state");
        try {
            wrapper.getResultSet().next();
            do {
                ret.add(new State(wrapper.getResultSet().getString("code"), wrapper.getResultSet().getString("name")));
            } while (wrapper.getResultSet().next());
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    public Key getKey(String keyName) {

        wrapper.createStatement();
        wrapper.findRecord("KEYS", "KEYNAME", keyName);
        try {
            Key ret = new Key(wrapper.getResultSet().getInt("id"), wrapper.getResultSet().getString("platform"), wrapper.getResultSet().getString("keyName"), wrapper.getResultSet().getString("keyValue"));
            return ret;
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Country getCountry(String countryCode) {

        wrapper.createStatement();
        wrapper.findRecord("COUNTRIES", "CODE", countryCode);
        try {
            Country ret = new Country(wrapper.getResultSet().getString("code"), wrapper.getResultSet().getString("name"), wrapper.getResultSet().getString("continentcode"));
            return ret;
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<String> getAllPositiveEmojis() {
        ArrayList ret = new ArrayList<String>();
        wrapper.createStatement();
        wrapper.createResultSet("SELECT * FROM positiveemojis");
        try {
            wrapper.getResultSet().next();
            do {
                ret.add(wrapper.getResultSet().getString("emoji"));
            } while (wrapper.getResultSet().next());
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    public ArrayList<String> getAllNegativeEmojis() {
        ArrayList ret = new ArrayList<String>();
        wrapper.createStatement();
        wrapper.createResultSet("SELECT * FROM negativeemojis");
        try {
            wrapper.getResultSet().next();
            do {
                ret.add(wrapper.getResultSet().getString("emoji"));
            } while (wrapper.getResultSet().next());
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    public void createTable(String tableName) {
        try {
            wrapper.createStatement();

            String sql = "CREATE TABLE " + tableName
                    + "(id int,"
                    + " ogUserName VARCHAR(64),"
                    + " ogStatus VARCHAR(500),"
                    + " ogComment VARCHAR(500),"
                    + " contextId int,"
                    + " followersCount int,"
                    + " favouriteCount int,"
                    + " friendCount int,"
                    + " location int,"
                    + " isVerified int,"
                    + " hasSwear int,"
                    + " hasPositiveWord int,"
                    + " hasNegativeWord int,"
                    + " hasPositiveEmoji int,"
                    + " hasNegativeEmoji int,"
                    + " classifier int)";

            wrapper.getStatement().executeUpdate(sql);

            System.out.println("Created " + tableName + " table successfully");
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertClassifier(HashMap<Integer, Integer> hmap, String tableName) {
        wrapper.createStatement();
        try {
            for (Map.Entry<Integer, Integer> entry : hmap.entrySet()) {
                wrapper.getStatement().executeUpdate("UPDATE " + tableName
                        + " SET classifier=" + entry.getValue()
                        + " WHERE id =" + entry.getKey());
            }
        } catch (SQLException ex) {
            Logger.getLogger(SocialMediaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getMaxContextId(String tableName) {
        int maxId = 0;
        wrapper.createStatement();
        wrapper.createResultSet("SELECT MAX(contextId) FROM " + tableName);
        try {
            while (wrapper.getResultSet().next()) {
                maxId = wrapper.getResultSet().getInt(1);
                if (wrapper.getResultSet().wasNull()) {
                    return -1;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NullPointerException ex) {
            return 0;
        }
        return maxId;
    }

    public int getMaxId(String tableName) {
        wrapper.createStatement();
        wrapper.createResultSet("SELECT MAX(id) FROM " + tableName);
        int maxId = 0;
        try {
            while (wrapper.getResultSet().next()) {
                maxId = wrapper.getResultSet().getInt(1);
                if (wrapper.getResultSet().wasNull()) {
                    return -1;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NullPointerException ex) {
            return 0;
        }
        return maxId;
    }
}
