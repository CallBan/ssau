package com.ssau.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Author implements Serializable {
  private int id;
  private String firstname;
  private String lastname;
  private Date birthdate;
  private String gender;
  private String country;
}
