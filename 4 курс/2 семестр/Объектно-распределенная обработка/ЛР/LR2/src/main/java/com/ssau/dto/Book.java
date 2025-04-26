package com.ssau.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book implements Serializable {
  private int id;
  private String name;
  private String publisher;
  private int authorId;
  private int rating;
}
