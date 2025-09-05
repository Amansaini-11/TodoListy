//
//  ListView.swift
//  GuessTheFlag
//
//  Created by Aman on 05/09/25.
//

import SwiftUI

struct ListView: View {

    @State private var numbers = [Int]()
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var numberCount = 1
    
    // UserDefaults keys for persistence
    private let usedWordsKey = "SavedUsedWords"
    private let numbersKey = "SavedNumbers"
    private let numberCountKey = "SavedNumberCount"
    
    var body: some View {
        NavigationStack{
            
            List(){
                
                Section{
                    TextField("Enter your Word", text: $newWord)
                        .autocapitalization(.none)
                        
                }
                
                Section(usedWords.isEmpty ? "" :"Array of Entries"){
                    
                    ForEach(usedWords, id: \.self) { word in
                      
                        Text(word)
                        
                    }.onDelete(perform: removeRows)
                    
                    ForEach(numbers, id: \.self){ number in
                        Text("Row \(number)")
                        
                    }.onDelete(perform: removeRows)
                }
               
            }
            
            Button("Add Raws"){
                numbers.append(numberCount)
                numberCount+=1
                saveData()
            }.buttonStyle(.borderedProminent)
                .tint(.green)
                .padding(5)
            
        }.navigationTitle("ToDoListy ✅")
            .toolbar(){
                EditButton()
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
            }
            .onSubmit {
                addWordToArray()
            }
            .onAppear {
                loadData()
            }
            
    }
    
//    function to add the 'remove item' functionality to the List Rows
    func removeRows(at offset: IndexSet){
        usedWords.remove(atOffsets: offset)
        saveData()
    }
    
//    This function is to add the User input data in the List
    func addWordToArray(){
        
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
//        Assign the input to the Array
        withAnimation(){
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        saveData()
    }
    
    // Data Persistence Functions to store the data locally
    
    func saveData() {
        UserDefaults.standard.set(usedWords, forKey: usedWordsKey)
        UserDefaults.standard.set(numbers, forKey: numbersKey)
        UserDefaults.standard.set(numberCount, forKey: numberCountKey)
    }
    
//    Load data funciton to load the previous data whenever the app launches
    
    func loadData() {
        if let savedWords = UserDefaults.standard.array(forKey: usedWordsKey) as? [String] {
            usedWords = savedWords
        }
        
        if let savedNumbers = UserDefaults.standard.array(forKey: numbersKey) as? [Int] {
            numbers = savedNumbers
        }
        
        if let savedNumberCount = UserDefaults.standard.object(forKey: numberCountKey) as? Int {
            numberCount = savedNumberCount
        }
    }
}



struct ContentView_previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ListView()
        }
    }
}

