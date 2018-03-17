package com.model;

import static com.model.ConditionCheck.getCountryFromLocation;
import static com.model.ConditionCheck.hasNegativeEmoji;
import static com.model.ConditionCheck.hasNegativeWord;
import static com.model.ConditionCheck.hasPositiveEmoji;
import static com.model.ConditionCheck.hasPositiveWord;
import static com.model.ConditionCheck.hasSwearWord;
import java.util.ArrayList;
import twitter4j.*;

/**
 *
 * @author Fraser
 */
public class Demographics {

    ArrayList<Country> locationReplies;
    ArrayList<Status> positiveEmojiReplies;
    ArrayList<Status> negativeEmojiReplies;
    ArrayList<Status> positiveWordReplies;
    ArrayList<Status> negativeWordReplies;
    ArrayList<Status> swearReplies;
    int totalFollowers;
    User mostFollowers;
    int totalFriends;
    User mostFriends;
    ArrayList<Status> verifiedReplies;
    ArrayList<Status> favouriteReplies;
    Status mostFavourited;

    public Demographics() {
        locationReplies = new ArrayList();
        positiveEmojiReplies = new ArrayList();
        negativeEmojiReplies = new ArrayList();
        positiveWordReplies = new ArrayList();
        negativeWordReplies = new ArrayList();
        swearReplies = new ArrayList();
        favouriteReplies = new ArrayList();
        verifiedReplies = new ArrayList();
    }

    public void setDemographics(ArrayList<Status> replies) {
        
        for (int i = 0; i < replies.size(); i++) {

            if (getCountryFromLocation(replies.get(i)) != null) {
                this.locationReplies.add(getCountryFromLocation(replies.get(i)));
            }

            if (hasPositiveWord(replies.get(i))) {
                this.positiveWordReplies.add(replies.get(i));
            }

            if (hasNegativeWord(replies.get(i))) {
                this.negativeWordReplies.add(replies.get(i));
            }

            if (hasPositiveEmoji(replies.get(i))) {
                this.positiveEmojiReplies.add(replies.get(i));
            }

            if (hasNegativeEmoji(replies.get(i))) {
                this.negativeEmojiReplies.add(replies.get(i));
            }

            if (hasSwearWord(replies.get(i))) {
                this.swearReplies.add(replies.get(i));
            }

            if (replies.get(i).getFavoriteCount() != 0) {
                this.favouriteReplies.add(replies.get(i));
            }

            totalFollowers = totalFollowers + replies.get(i).getUser().getFollowersCount();
                         
            if (mostFollowers == null || mostFollowers.getFollowersCount() < replies.get(i).getUser().getFollowersCount()) {
                this.mostFollowers = replies.get(i).getUser();
            }

            totalFriends = totalFriends + replies.get(i).getUser().getFriendsCount();
            
            if (mostFriends == null || mostFriends.getFriendsCount() < replies.get(i).getUser().getFriendsCount()) {
                this.mostFriends = replies.get(i).getUser();
            }

            if (replies.get(i).getUser().isVerified()) {
                this.verifiedReplies.add(replies.get(i));
            }
            
            if (mostFavourited == null || mostFavourited.getFavoriteCount() < replies.get(i).getFavoriteCount()) {
                this.mostFavourited = replies.get(i);
            }
        }
    }

    // GETTERS
    public ArrayList<Country> getLocationReplies() {
        return locationReplies;
    }

    public ArrayList<Status> getPositiveEmojiReplies() {
        return positiveEmojiReplies;
    }

    public ArrayList<Status> getNegativeEmojiReplies() {
        return negativeEmojiReplies;
    }

    public ArrayList<Status> getPositiveWordReplies() {
        return positiveWordReplies;
    }

    public ArrayList<Status> getNegativeWordReplies() {
        return negativeWordReplies;
    }

    public ArrayList<Status> getSwearReplies() {
        return swearReplies;
    }

    public int getTotalFollowers() {
        return totalFollowers;
    }

    public int getTotalFriends() {
        return totalFriends;
    }

    public ArrayList<Status> getVerifiedReplies() {
        return verifiedReplies;
    }

    public ArrayList<Status> getFavouriteReplies() {
        return favouriteReplies;
    }

    public User getMostFollowers() {
        return mostFollowers;
    }

    public User getMostFriends() {
        return mostFriends;
    }

    public Status getMostFavourited() {
        return mostFavourited;
    }

    
}
